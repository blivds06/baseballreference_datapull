from bs4 import BeautifulSoup
from bs4 import Comment
import pandas as pd
import os.path
import requests
import pandas as pd
import numpy as np
from datetime import date, datetime


def standardbattingdata(year):
    # Get Standard Batting Data based on year
    r = requests.get(
        "https://www.baseball-reference.com/leagues/majors/"
        + str(year)
        + "-standard-batting.shtml"
    )
    soup = BeautifulSoup(r.text, features="lxml")
    html_table = [
        x.extract()
        for x in soup.find_all(string=lambda text: isinstance(text, Comment))
        if 'id="div_players_standard_batting"' in x
    ][0]

    main_df = pd.read_html(html_table)[0]
    main_df = main_df[(main_df["Rk"].notnull()) & (main_df["Rk"] != "Rk")]
    main_df.set_index("Rk", inplace=True)

    player_cde_df = pd.DataFrame(
        [
            (a.find_previous("th").text, a.get("data-append-csv"))
            for a in BeautifulSoup(html_table, features="lxml").select(
                "[data-append-csv]"
            )
        ],
        columns=["Rk", "data-append-csv"],
        dtype="object",
    )
    player_cde_df.set_index("Rk", inplace=True)
    player_cde_df = player_cde_df.rename(columns={"data-append-csv": "Player_CDE"})

    data = main_df.join(player_cde_df).reset_index()

    data["LevelOfDeatil_DSC"] = "Standard Batting Data"
    data["Load_DTM"] = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    data["Year"] = year
    return data


def individualbattingdata(player_cde, year=-1):
    SpecialChar = player_cde[0:1]
    html_link = (
        "https://www.baseball-reference.com/players/"
        + SpecialChar
        + "/"
        + player_cde
        + ".shtml"
    )
    r = requests.get(html_link)
    soup = BeautifulSoup(r.text, features="lxml")
    html_table = [
        x.extract()
        for x in soup.find_all(string=lambda text: isinstance(text, Comment))
        if 'id="div_batting_value"' in x
    ][0]
    data = pd.read_html(html_table)[0]
    data = data[data["Lg"].notnull()]
    if str(year).strip() != "-1":
        data = data[data["Year"] == str(year).strip()]
    data["Player_CDE"] = player_cde
    data["LevelOfDeatil_DSC"] = "Individual Player Data"
    data["Load_DTM"] = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    data["Year"] = year
    return data


def battingplatoonsplits(player_cde, year):
    html_link = (
        "https://www.baseball-reference.com/players/split.fcgi?id="
        + player_cde
        + "&year="
        + str(year).strip()
        + "&t=b"
    )
    r = requests.get(html_link)
    soup = BeautifulSoup(r.text, features="lxml")
    html_table = [
        x.extract()
        for x in soup.find_all(string=lambda text: isinstance(text, Comment))
        if 'id="div_plato"' in x
    ][0]
    data = pd.read_html(html_table)[0]
    data["Player_CDE"] = player_cde
    data["LevelOfDeatil_DSC"] = "Batting Platoon Splits"
    data["Load_DTM"] = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    data["Year"] = year
    return data


def standardpitchingdata(year):
    # Get Standard Batting Data based on year
    r = requests.get(
        "https://www.baseball-reference.com/leagues/majors/"
        + str(year)
        + "-standard-pitching.shtml"
    )
    soup = BeautifulSoup(r.text, features="lxml")
    html_table = [
        x.extract()
        for x in soup.find_all(string=lambda text: isinstance(text, Comment))
        if 'id="div_players_standard_pitching"' in x
    ][0]

    main_df = pd.read_html(html_table)[0]
    main_df = main_df[(main_df["Rk"].notnull()) & (main_df["Rk"] != "Rk")]
    main_df.set_index("Rk", inplace=True)

    player_cde_df = pd.DataFrame(
        [
            (a.find_previous("th").text, a.get("data-append-csv"))
            for a in BeautifulSoup(html_table, features="lxml").select(
                "[data-append-csv]"
            )
        ],
        columns=["Rk", "data-append-csv"],
        dtype="object",
    )
    player_cde_df.set_index("Rk", inplace=True)
    player_cde_df = player_cde_df.rename(columns={"data-append-csv": "Player_CDE"})

    data = main_df.join(player_cde_df).reset_index()

    data["LevelOfDeatil_DSC"] = "Standard Pitching Data"
    data["Load_DTM"] = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    data["Year"] = year

    return data


def pitchingplatoonsplits(player_cde, year):
    html_link = (
        "https://www.baseball-reference.com/players/split.fcgi?id="
        + player_cde
        + "&year="
        + str(year).strip()
        + "&t=p"
    )
    r = requests.get(html_link)
    soup = BeautifulSoup(r.text, features="lxml")
    html_table = [
        x.extract()
        for x in soup.find_all(string=lambda text: isinstance(text, Comment))
        if 'id="div_plato"' in x
    ][0]
    data = pd.read_html(html_table)[0]
    data["Player_CDE"] = player_cde
    data["LevelOfDeatil_DSC"] = "Pitching Platoon Splits"
    data["Load_DTM"] = datetime.now().strftime("%m/%d/%Y %H:%M:%S")
    data["Year"] = year
    return data
