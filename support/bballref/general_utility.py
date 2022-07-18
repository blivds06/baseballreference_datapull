import logging
import time
import math
import pandas as pd
import pyodbc
import os

from bballref.config import config

logger = logging.getLogger(__name__)


def convert_size(size_bytes):
    """Converts bytes into proper size.
    
    Parameters
    ---------
    size_bytes : int
        The number of bytes of any memory object.
    
    Returns
    ---------
    str
    """
    if size_bytes == 0:
        return "0 B"
    size_name = ("B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB")
    i = int(math.floor(math.log(size_bytes, 1024)))
    p = math.pow(1024, i)
    s = round(size_bytes / p, 2)
    return "%s %s" % (s, size_name[i])


def size_of_dataframe(data):
    """Return the size of the dataframe.
    
    Parameters
    ----------
    data : pd.DataFrame
        The dataframe in which to return the total size in memory.
    """
    return convert_size(data.memory_usage(deep=True).sum())


def write_parquet(data, path, compression="gzip", index=False):

    try:
        logger.info(f"\n Writing data to {path}.")
        data.to_parquet(path, compression=compression, index=index)
        logger.info(
            f"\n Data saved to: {path} \n Number of Columns: "
            ""
            + str(len(data.columns))
            + """\n Number of Rows: """
            + str(len(data))
            + """\n Total Memory of Dataframe: """
            + str(size_of_dataframe(data))
        )
    except Exception as e:
        logger.error(f"{e}")
        raise


def read_parquet(path):
    try:
        logger.info(f"\n Reading data from {path}.")
        data = pd.read_parquet(path)
        logger.info(
            f"\n Number of Columns: "
            ""
            + str(len(data.columns))
            + """\n Number of Rows: """
            + str(len(data))
            + """\n Total Memory of Dataframe: """
            + str(size_of_dataframe(data))
        )
    except Exception as e:
        logger.error(f"{e}")
        raise
    return data


def assignmetadata(df, table_id):
    if table_id == "STANDARD_PITCHING_DATA":
        df["Rk"] = df["Rk"].astype(str).astype(int)
        df["Age"] = df["Age"].astype(str).astype(int)
        df["W"] = df["W"].astype(str).astype(int)
        df["L"] = df["L"].astype(str).astype(int)
        df["G"] = df["G"].astype(str).astype(int)
        df["GS"] = df["GS"].astype(str).astype(int)
        df["GF"] = df["GF"].astype(str).astype(int)
        df["CG"] = df["CG"].astype(str).astype(int)
        df["SHO"] = df["SHO"].astype(str).astype(int)
        df["SV"] = df["SV"].astype(str).astype(int)
        df["H"] = df["H"].astype(str).astype(int)
        df["R"] = df["R"].astype(str).astype(int)
        df["ER"] = df["ER"].astype(str).astype(int)
        df["HR"] = df["HR"].astype(str).astype(int)
        df["BB"] = df["BB"].astype(str).astype(int)
        df["IBB"] = df["IBB"].astype(str).astype(int)
        df["SO"] = df["SO"].astype(str).astype(int)
        df["HBP"] = df["HBP"].astype(str).astype(int)
        df["BK"] = df["BK"].astype(str).astype(int)
        df["WP"] = df["WP"].astype(str).astype(int)
        df["BF"] = df["BF"].astype(str).astype(int)
        # There is a nan in an object. Changing the nan to a string of -14, doing the conversion to int, then chaning -14 to None
        df["ERA+"] = df["ERA+"].fillna("-14")
        df["ERA+"] = df["ERA+"].astype(str).astype(int)
        df["ERA+"] = df["ERA+"].replace(-14, None)
        # End ERA+ assigning metadata logic
        df["W-L%"] = df["W-L%"].astype(str).astype(float)
        df["ERA"] = df["ERA"].astype(str).astype(float)
        df["IP"] = df["IP"].astype(str).astype(float)
        df["FIP"] = df["FIP"].astype(str).astype(float)
        df["WHIP"] = df["WHIP"].astype(str).astype(float)
        df["H9"] = df["H9"].astype(str).astype(float)
        df["HR9"] = df["HR9"].astype(str).astype(float)
        df["BB9"] = df["BB9"].astype(str).astype(float)
        df["SO9"] = df["SO9"].astype(str).astype(float)
        df["SO/W"] = df["SO/W"].astype(str).astype(float)
    if table_id == "STANDARD_BATTING_DATA":
        df["Rk"] = df["Rk"].astype(str).astype(int)
        df["Age"] = df["Age"].astype(str).astype(int)
        df["G"] = df["G"].astype(str).astype(int)
        df["PA"] = df["PA"].astype(str).astype(int)
        df["AB"] = df["AB"].astype(str).astype(int)
        df["R"] = df["R"].astype(str).astype(int)
        df["H"] = df["H"].astype(str).astype(int)
        df["2B"] = df["2B"].astype(str).astype(int)
        df["3B"] = df["3B"].astype(str).astype(int)
        df["HR"] = df["HR"].astype(str).astype(int)
        df["RBI"] = df["RBI"].astype(str).astype(int)
        df["SB"] = df["SB"].astype(str).astype(int)
        df["CS"] = df["CS"].astype(str).astype(int)
        df["BB"] = df["BB"].astype(str).astype(int)
        df["SO"] = df["SO"].astype(str).astype(int)
        # There is a nan in an object. Changing the nan to a string of -14, doing the conversion to int, then chaning -14 to None
        df["OPS+"] = df["OPS+"].fillna("-14")
        df["OPS+"] = df["OPS+"].astype(str).astype(int)
        df["OPS+"] = df["OPS+"].replace(-14, None)
        # End OPS+ assigning metadata logic
        df["TB"] = df["TB"].astype(str).astype(int)
        df["GDP"] = df["GDP"].astype(str).astype(int)
        df["HBP"] = df["HBP"].astype(str).astype(int)
        df["SH"] = df["SH"].astype(str).astype(int)
        df["SF"] = df["SF"].astype(str).astype(int)
        df["IBB"] = df["IBB"].astype(str).astype(int)
        df["Year"] = df["Year"].astype(str).astype(int)
        df["BA"] = df["BA"].astype(str).astype(float)
        df["OBP"] = df["OBP"].astype(str).astype(float)
        df["SLG"] = df["SLG"].astype(str).astype(float)
        df["OPS"] = df["OPS"].astype(str).astype(float)
    return None
