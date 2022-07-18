<h2>Baseball Reference Data Pull</h2>

The goal of this python repository is to provide the end user baseball datasets from www.baseball-reference.com. These datasets are eventually stored off in a local instance of SQL Server. The end user brings in the data into excel to do their analysis to make decisions in their Strat-O-Matic baseball league.

<h3>Quick Overview of Strat-O-Matic Baseball:</h3>

Strat-O-Matic Baseball (SOMB) is a baseball simulation game that uses chance and actual historical player statistics to determine the outcome of a simulated game. In SOMB, actual baseball games are played where each at bat is simulated by dice rolls. The results of the at bat are determined by using a combination of the dice roll and statistically developed “cards” for each player (both batter and pitcher). These cards are derived directly from historical player statistics from any given year. Individuals who play SOMB manage teams in a game simulation to give it a real life feel (games are played against other individual managers or computer-generated managers). Numerous leagues have been formed where individuals manage teams against each other – with drafts sometimes used to determine team rosters.

<h3>How to use this repository:</h3>

Prerequirements:
<ol>
    <li>Install Python</li>
    <li>Install SQL Server</li>
    <li>Install SQL Server Management Studio</li>
    </ol>
    
<i>Note: You will need to create your own SQL instance and database and have some familiarly with SQL Server. These instructions are not posted here.</i>

How to run the programs:
<ol><li>Open up SQL Server Management Studio. Open up the CreateObjects.sql script from the scripts folder and execute the script on your database. (Only need to do this once).<br>
    <i>Behind the scenes: I utilize a DACPAC (Database Package) via Visual Studio SSDT on my end. For convenient sake of some users not being familiar with this concept, I provided the CreateObjects.sql script in the scripts folder which creates all the objects in an easy way.</i></li>
    <li>Clone the GIT repository to a location on your computer.</li>
    <li>Open Anaconda Prompt</li>
    <li>Change directory to your location to where you stored the files<br><br>
    <code>cd /d "{Enter Your folder location here}"</code><br><br></li>
    <li>Create the environment using the following code:<br><br>
    <code>conda env create -f environment.yml -p ./env_bballref</code><br><br>
    </li>
    <li>Once the environment is setup, activate the environment and go into jupyter notebook (or jupyter lab)<br><br>
    <code>conda activate {environment path}</code><br><br>
    <code>jupyter notebook</code><br><br>
    </li>
    <li>At this point, you will need to modify the project_config.json file. Open this file up. Edit the following fields:
    <ol>
        <li>logs_path: Location of where the logs will right out to.</li>
        <li>main_project_path: The main project path of where the project is. Note: The writing of logs is currently disabled. Default setup is set to do a standard out.</li>
        <li>data_path: The location of where the local datasets are going to be stored before being pushed to SQL Server</li>
        <li>sqlsvr: This houses the connection information to the SQL Server/Database you want to store the data in</li>
        <li>year: The year of data you want to pull. Based on the way the program is setup, you can only pull one year at a time.</li>
    </ol>
</li>
    <li>Go into the notebooks folder and run the following notebooks in order:
    <ol>
        <li>bballref_01_batting_data</li>
        <li>bballref_05_pitching_data</li>
        <li>bballref_10_load_to_sql</li>
    </ol>
</li>
<li>Go back to SQL Server Management Studio and execute both stored procedures.</li>
<li>Build your query off the views to pull the data and you are good to go.</li>
<li>If you want more years, change the year in the config file, rerun the notebooks in the same order, return the execution of the stored procedures and data should flow into your STRATO tables. </li>
    </ol>
