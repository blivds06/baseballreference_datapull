CREATE PROCEDURE [dbo].[sp_IMPORT_INTO_STRATO_BATTING_DATA]

AS

IF OBJECT_ID('Tempdb..#PLAYERS_WITH_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITH_TOT
IF OBJECT_ID('Tempdb..#PLAYERS_WITHOUT_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITHOUT_TOT
IF OBJECT_ID('Tempdb..#TOT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#TOT_WITHOUT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_WITHOUT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#STRATO_BATTING_DATA') IS NOT NULL DROP TABLE #STRATO_BATTING_DATA


/* Players with a total Record*/
Select Distinct Player_CDE
,'Y' as TotalRecord_IND
Into #PLAYERS_WITH_TOT
From STANDARD_BATTING_DATA
Where Tm = 'TOT'

/* Players without a total Record*/
Select Distinct S.Player_CDE
,'N' as TotalRecord_IND
Into #PLAYERS_WITHOUT_TOT
From STANDARD_BATTING_DATA S
left join #PLAYERS_WITH_TOT P
on S.Player_CDE = P.Player_CDE
Where P.Player_CDE is null

Select COALESCE(LHP.Player_CDE,RHP.Player_CDE) as Player_CDE
,COALESCE(LHP.Tm,RHP.Tm) as Tm
,COALESCE(LHP.Year,RHP.Year) as Year
,COALESCE(LHP.Lg,RHP.Lg) as Lg
,LHP.[G-vsLHP]
,LHP.[GS-vsLHP]
,LHP.[PA-vsLHP]
,LHP.[AB-vsLHP]
,LHP.[R-vsLHP]
,LHP.[H-vsLHP]
,LHP.[2B-vsLHP]
,LHP.[3B-vsLHP]
,LHP.[HR-vsLHP]
,LHP.[RBI-vsLHP]
,LHP.[SB-vsLHP]
,LHP.[CS-vsLHP]
,LHP.[BB-vsLHP]
,LHP.[SO-vsLHP]
,LHP.[BA-vsLHP]
,LHP.[OBP-vsLHP]
,LHP.[SLG-vsLHP]
,LHP.[OPS-vsLHP]
,LHP.[TB-vsLHP]
,LHP.[GDP-vsLHP]
,LHP.[HBP-vsLHP]
,LHP.[SH-vsLHP]
,LHP.[SF-vsLHP]
,LHP.[IBB-vsLHP]
,LHP.[ROE-vsLHP]
,LHP.[BAbip-vsLHP]
,LHP.[tOPS+-vsLHP]
,LHP.[sOPS+-vsLHP]
,RHP.[G-vsRHP]
,RHP.[GS-vsRHP]
,RHP.[PA-vsRHP]
,RHP.[AB-vsRHP]
,RHP.[R-vsRHP]
,RHP.[H-vsRHP]
,RHP.[2B-vsRHP]
,RHP.[3B-vsRHP]
,RHP.[HR-vsRHP]
,RHP.[RBI-vsRHP]
,RHP.[SB-vsRHP]
,RHP.[CS-vsRHP]
,RHP.[BB-vsRHP]
,RHP.[SO-vsRHP]
,RHP.[BA-vsRHP]
,RHP.[OBP-vsRHP]
,RHP.[SLG-vsRHP]
,RHP.[OPS-vsRHP]
,RHP.[TB-vsRHP]
,RHP.[GDP-vsRHP]
,RHP.[HBP-vsRHP]
,RHP.[SH-vsRHP]
,RHP.[SF-vsRHP]
,RHP.[IBB-vsRHP]
,RHP.[ROE-vsRHP]
,RHP.[BAbip-vsRHP]
,RHP.[tOPS+-vsRHP]
,RHP.[sOPS+-vsRHP]
Into #TOT_SPLIT_DATA
From
(
Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsLHP]
,P.[GS] as [GS-vsLHP]
,P.[PA] as [PA-vsLHP]
,P.[AB] as [AB-vsLHP]
,P.[R] as [R-vsLHP]
,P.[H] as [H-vsLHP]
,P.[2B] as [2B-vsLHP]
,P.[3B] as [3B-vsLHP]
,P.[HR] as [HR-vsLHP]
,P.[RBI] as [RBI-vsLHP]
,P.[SB] as [SB-vsLHP]
,P.[CS] as [CS-vsLHP]
,P.[BB] as [BB-vsLHP]
,P.[SO] as [SO-vsLHP]
,P.[BA] as [BA-vsLHP]
,P.[OBP] as [OBP-vsLHP]
,P.[SLG] as [SLG-vsLHP]
,P.[OPS] as [OPS-vsLHP]
,P.[TB] as [TB-vsLHP]
,P.[GDP] as [GDP-vsLHP]
,P.[HBP] as [HBP-vsLHP]
,P.[SH] as [SH-vsLHP]
,P.[SF] as [SF-vsLHP]
,P.[IBB] as [IBB-vsLHP]
,P.[ROE] as [ROE-vsLHP]
,P.[BAbip] as [BAbip-vsLHP]
,P.[tOPS+] as [tOPS+-vsLHP]
,P.[sOPS+] as [sOPS+-vsLHP]

From #PLAYERS_WITH_TOT PWT
inner join STANDARD_BATTING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_BATTING_DATA P
on S.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
and S.Lg = 'MLB'
and Split = 'vs LHP'
) LHP
full outer join
(

Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsRHP]
,P.[GS] as [GS-vsRHP]
,P.[PA] as [PA-vsRHP]
,P.[AB] as [AB-vsRHP]
,P.[R] as [R-vsRHP]
,P.[H] as [H-vsRHP]
,P.[2B] as [2B-vsRHP]
,P.[3B] as [3B-vsRHP]
,P.[HR] as [HR-vsRHP]
,P.[RBI] as [RBI-vsRHP]
,P.[SB] as [SB-vsRHP]
,P.[CS] as [CS-vsRHP]
,P.[BB] as [BB-vsRHP]
,P.[SO] as [SO-vsRHP]
,P.[BA] as [BA-vsRHP]
,P.[OBP] as [OBP-vsRHP]
,P.[SLG] as [SLG-vsRHP]
,P.[OPS] as [OPS-vsRHP]
,P.[TB] as [TB-vsRHP]
,P.[GDP] as [GDP-vsRHP]
,P.[HBP] as [HBP-vsRHP]
,P.[SH] as [SH-vsRHP]
,P.[SF] as [SF-vsRHP]
,P.[IBB] as [IBB-vsRHP]
,P.[ROE] as [ROE-vsRHP]
,P.[BAbip] as [BAbip-vsRHP]
,P.[tOPS+] as [tOPS+-vsRHP]
,P.[sOPS+] as [sOPS+-vsRHP]
From #PLAYERS_WITH_TOT PWT
inner join STANDARD_BATTING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_BATTING_DATA P
on S.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
and S.Lg = 'MLB'
and Split = 'vs RHP'
) RHP
on LHP.Player_CDE = RHP.Player_CDE


/**********************************************************/

/*****/

Select COALESCE(LHP.Player_CDE,RHP.Player_CDE) as Player_CDE
,COALESCE(LHP.Tm,RHP.Tm) as Tm
,COALESCE(LHP.Year,RHP.Year) as Year
,COALESCE(LHP.Lg,RHP.Lg) as Lg
,LHP.[G-vsLHP]
,LHP.[GS-vsLHP]
,LHP.[PA-vsLHP]
,LHP.[AB-vsLHP]
,LHP.[R-vsLHP]
,LHP.[H-vsLHP]
,LHP.[2B-vsLHP]
,LHP.[3B-vsLHP]
,LHP.[HR-vsLHP]
,LHP.[RBI-vsLHP]
,LHP.[SB-vsLHP]
,LHP.[CS-vsLHP]
,LHP.[BB-vsLHP]
,LHP.[SO-vsLHP]
,LHP.[BA-vsLHP]
,LHP.[OBP-vsLHP]
,LHP.[SLG-vsLHP]
,LHP.[OPS-vsLHP]
,LHP.[TB-vsLHP]
,LHP.[GDP-vsLHP]
,LHP.[HBP-vsLHP]
,LHP.[SH-vsLHP]
,LHP.[SF-vsLHP]
,LHP.[IBB-vsLHP]
,LHP.[ROE-vsLHP]
,LHP.[BAbip-vsLHP]
,LHP.[tOPS+-vsLHP]
,LHP.[sOPS+-vsLHP]
,RHP.[G-vsRHP]
,RHP.[GS-vsRHP]
,RHP.[PA-vsRHP]
,RHP.[AB-vsRHP]
,RHP.[R-vsRHP]
,RHP.[H-vsRHP]
,RHP.[2B-vsRHP]
,RHP.[3B-vsRHP]
,RHP.[HR-vsRHP]
,RHP.[RBI-vsRHP]
,RHP.[SB-vsRHP]
,RHP.[CS-vsRHP]
,RHP.[BB-vsRHP]
,RHP.[SO-vsRHP]
,RHP.[BA-vsRHP]
,RHP.[OBP-vsRHP]
,RHP.[SLG-vsRHP]
,RHP.[OPS-vsRHP]
,RHP.[TB-vsRHP]
,RHP.[GDP-vsRHP]
,RHP.[HBP-vsRHP]
,RHP.[SH-vsRHP]
,RHP.[SF-vsRHP]
,RHP.[IBB-vsRHP]
,RHP.[ROE-vsRHP]
,RHP.[BAbip-vsRHP]
,RHP.[tOPS+-vsRHP]
,RHP.[sOPS+-vsRHP]
Into #TOT_WITHOUT_SPLIT_DATA
From
(
Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsLHP]
,P.[GS] as [GS-vsLHP]
,P.[PA] as [PA-vsLHP]
,P.[AB] as [AB-vsLHP]
,P.[R] as [R-vsLHP]
,P.[H] as [H-vsLHP]
,P.[2B] as [2B-vsLHP]
,P.[3B] as [3B-vsLHP]
,P.[HR] as [HR-vsLHP]
,P.[RBI] as [RBI-vsLHP]
,P.[SB] as [SB-vsLHP]
,P.[CS] as [CS-vsLHP]
,P.[BB] as [BB-vsLHP]
,P.[SO] as [SO-vsLHP]
,P.[BA] as [BA-vsLHP]
,P.[OBP] as [OBP-vsLHP]
,P.[SLG] as [SLG-vsLHP]
,P.[OPS] as [OPS-vsLHP]
,P.[TB] as [TB-vsLHP]
,P.[GDP] as [GDP-vsLHP]
,P.[HBP] as [HBP-vsLHP]
,P.[SH] as [SH-vsLHP]
,P.[SF] as [SF-vsLHP]
,P.[IBB] as [IBB-vsLHP]
,P.[ROE] as [ROE-vsLHP]
,P.[BAbip] as [BAbip-vsLHP]
,P.[tOPS+] as [tOPS+-vsLHP]
,P.[sOPS+] as [sOPS+-vsLHP]

From #PLAYERS_WITHOUT_TOT PWT
inner join STANDARD_BATTING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_BATTING_DATA P
on S.Player_CDE = P.Player_CDE
Where Split = 'vs LHP'

) LHP
full outer join
(

Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsRHP]
,P.[GS] as [GS-vsRHP]
,P.[PA] as [PA-vsRHP]
,P.[AB] as [AB-vsRHP]
,P.[R] as [R-vsRHP]
,P.[H] as [H-vsRHP]
,P.[2B] as [2B-vsRHP]
,P.[3B] as [3B-vsRHP]
,P.[HR] as [HR-vsRHP]
,P.[RBI] as [RBI-vsRHP]
,P.[SB] as [SB-vsRHP]
,P.[CS] as [CS-vsRHP]
,P.[BB] as [BB-vsRHP]
,P.[SO] as [SO-vsRHP]
,P.[BA] as [BA-vsRHP]
,P.[OBP] as [OBP-vsRHP]
,P.[SLG] as [SLG-vsRHP]
,P.[OPS] as [OPS-vsRHP]
,P.[TB] as [TB-vsRHP]
,P.[GDP] as [GDP-vsRHP]
,P.[HBP] as [HBP-vsRHP]
,P.[SH] as [SH-vsRHP]
,P.[SF] as [SF-vsRHP]
,P.[IBB] as [IBB-vsRHP]
,P.[ROE] as [ROE-vsRHP]
,P.[BAbip] as [BAbip-vsRHP]
,P.[tOPS+] as [tOPS+-vsRHP]
,P.[sOPS+] as [sOPS+-vsRHP]
From #PLAYERS_WITHOUT_TOT PWT
inner join STANDARD_BATTING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_BATTING_DATA P
on S.Player_CDE = P.Player_CDE
Where Split = 'vs RHP'

) RHP
on LHP.Player_CDE = RHP.Player_CDE


Select S.[Rk]
,S.[Name]
,S.[Year]
,S.[Age]
,S.[Tm]
,S.[Lg]
,S.[G]
,S.[PA]
,S.[AB]
,S.[R]
,S.[H]
,S.[2B]
,S.[3B]
,S.[HR]
,S.[RBI]
,S.[SB]
,S.[CS]
,S.[BB]
,S.[SO]
,S.[BA]
,S.[OBP]
,S.[SLG]
,S.[OPS]
,S.[OPS+]
,S.[TB]
,S.[GDP]
,S.[HBP]
,S.[SH]
,S.[SF]
,S.[IBB]
,S.[Pos Summary]
,S.[Player_CDE]
,A.[G-vsLHP]
,A.[GS-vsLHP]
,A.[PA-vsLHP]
,A.[AB-vsLHP]
,A.[R-vsLHP]
,A.[H-vsLHP]
,A.[2B-vsLHP]
,A.[3B-vsLHP]
,A.[HR-vsLHP]
,A.[RBI-vsLHP]
,A.[SB-vsLHP]
,A.[CS-vsLHP]
,A.[BB-vsLHP]
,A.[SO-vsLHP]
,A.[BA-vsLHP]
,A.[OBP-vsLHP]
,A.[SLG-vsLHP]
,A.[OPS-vsLHP]
,A.[TB-vsLHP]
,A.[GDP-vsLHP]
,A.[HBP-vsLHP]
,A.[SH-vsLHP]
,A.[SF-vsLHP]
,A.[IBB-vsLHP]
,A.[ROE-vsLHP]
,A.[BAbip-vsLHP]
,A.[tOPS+-vsLHP]
,A.[sOPS+-vsLHP]
,A.[G-vsRHP]
,A.[GS-vsRHP]
,A.[PA-vsRHP]
,A.[AB-vsRHP]
,A.[R-vsRHP]
,A.[H-vsRHP]
,A.[2B-vsRHP]
,A.[3B-vsRHP]
,A.[HR-vsRHP]
,A.[RBI-vsRHP]
,A.[SB-vsRHP]
,A.[CS-vsRHP]
,A.[BB-vsRHP]
,A.[SO-vsRHP]
,A.[BA-vsRHP]
,A.[OBP-vsRHP]
,A.[SLG-vsRHP]
,A.[OPS-vsRHP]
,A.[TB-vsRHP]
,A.[GDP-vsRHP]
,A.[HBP-vsRHP]
,A.[SH-vsRHP]
,A.[SF-vsRHP]
,A.[IBB-vsRHP]
,A.[ROE-vsRHP]
,A.[BAbip-vsRHP]
,A.[tOPS+-vsRHP]
,A.[sOPS+-vsRHP]
Into #STRATO_BATTING_DATA
From STANDARD_BATTING_DATA S
left join (
Select *
From #TOT_SPLIT_DATA
UNION ALL
Select *
From #TOT_WITHOUT_SPLIT_DATA
) A
on S.Player_CDE = A.Player_CDE
and S.Year = A.Year
and S.Tm = A.Tm
and S.Lg = A.Lg
Order By Rk

INSERT INTO STRATO_BATTING_DATA Select * From #STRATO_BATTING_DATA


RETURN 0

CREATE PROCEDURE [dbo].[sp_IMPORT_INTO_STRATO_PITCHING_DATA]

AS

IF OBJECT_ID('Tempdb..#PLAYERS_WITH_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITH_TOT
IF OBJECT_ID('Tempdb..#PLAYERS_WITHOUT_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITHOUT_TOT
IF OBJECT_ID('Tempdb..#TOT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#TOT_WITHOUT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_WITHOUT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#STRATO_PITCHING_DATA') IS NOT NULL DROP TABLE #STRATO_PITCHING_DATA

/* Players with a total Record*/
Select Distinct Player_CDE
,'Y' as TotalRecord_IND
Into #PLAYERS_WITH_TOT
From STANDARD_PITCHING_DATA
Where Tm = 'TOT'

/* Players without a total Record*/
Select Distinct S.Player_CDE
,'N' as TotalRecord_IND
Into #PLAYERS_WITHOUT_TOT
From STANDARD_PITCHING_DATA S
left join #PLAYERS_WITH_TOT P
on S.Player_CDE = P.Player_CDE
Where P.Player_CDE is null

Select COALESCE(LHB.Player_CDE,RHB.Player_CDE) as Player_CDE
,COALESCE(LHB.Tm,RHB.Tm) as Tm
,COALESCE(LHB.Year,RHB.Year) as Year
,COALESCE(LHB.Lg,RHB.Lg) as Lg
,LHB.[G-vsLHB]
,LHB.[PA-vsLHB]
,LHB.[AB-vsLHB]
,LHB.[R-vsLHB]
,LHB.[H-vsLHB]
,LHB.[2B-vsLHB]
,LHB.[3B-vsLHB]
,LHB.[HR-vsLHB]
,LHB.[SB-vsLHB]
,LHB.[CS-vsLHB]
,LHB.[BB-vsLHB]
,LHB.[SO-vsLHB]
,LHB.[SO/W-vsLHB]
,LHB.[BA-vsLHB]
,LHB.[OBP-vsLHB]
,LHB.[SLG-vsLHB]
,LHB.[OPS-vsLHB]
,LHB.[TB-vsLHB]
,LHB.[GDP-vsLHB]
,LHB.[HBP-vsLHB]
,LHB.[SH-vsLHB]
,LHB.[SF-vsLHB]
,LHB.[IBB-vsLHB]
,LHB.[ROE-vsLHB]
,LHB.[BAbip-vsLHB]
,LHB.[tOPS+-vsLHB]
,LHB.[sOPS+-vsLHB]
,RHB.[G-vsRHB]
,RHB.[PA-vsRHB]
,RHB.[AB-vsRHB]
,RHB.[R-vsRHB]
,RHB.[H-vsRHB]
,RHB.[2B-vsRHB]
,RHB.[3B-vsRHB]
,RHB.[HR-vsRHB]
,RHB.[SB-vsRHB]
,RHB.[CS-vsRHB]
,RHB.[BB-vsRHB]
,RHB.[SO-vsRHB]
,RHB.[SO/W-vsRHB]
,RHB.[BA-vsRHB]
,RHB.[OBP-vsRHB]
,RHB.[SLG-vsRHB]
,RHB.[OPS-vsRHB]
,RHB.[TB-vsRHB]
,RHB.[GDP-vsRHB]
,RHB.[HBP-vsRHB]
,RHB.[SH-vsRHB]
,RHB.[SF-vsRHB]
,RHB.[IBB-vsRHB]
,RHB.[ROE-vsRHB]
,RHB.[BAbip-vsRHB]
,RHB.[tOPS+-vsRHB]
,RHB.[sOPS+-vsRHB]
Into #TOT_SPLIT_DATA
From
(
Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsLHB]
,P.[PA] as [PA-vsLHB]
,P.[AB] as [AB-vsLHB]
,P.[R] as [R-vsLHB]
,P.[H] as [H-vsLHB]
,P.[2B] as [2B-vsLHB]
,P.[3B] as [3B-vsLHB]
,P.[HR] as [HR-vsLHB]
,P.[SB] as [SB-vsLHB]
,P.[CS] as [CS-vsLHB]
,P.[BB] as [BB-vsLHB]
,P.[SO] as [SO-vsLHB]
,P.[SO/W] as [SO/W-vsLHB]
,P.[BA] as [BA-vsLHB]
,P.[OBP] as [OBP-vsLHB]
,P.[SLG] as [SLG-vsLHB]
,P.[OPS] as [OPS-vsLHB]
,P.[TB] as [TB-vsLHB]
,P.[GDP] as [GDP-vsLHB]
,P.[HBP] as [HBP-vsLHB]
,P.[SH] as [SH-vsLHB]
,P.[SF] as [SF-vsLHB]
,P.[IBB] as [IBB-vsLHB]
,P.[ROE] as [ROE-vsLHB]
,P.[BAbip] as [BAbip-vsLHB]
,P.[tOPS+] as [tOPS+-vsLHB]
,P.[sOPS+] as [sOPS+-vsLHB]
From #PLAYERS_WITH_TOT PWT
inner join STANDARD_PITCHING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_PITCHING_DATA P
on S.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
and S.Lg = 'MLB'
and Split = 'vs LHB'
) LHB
full outer join
(

Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsRHB]
,P.[PA] as [PA-vsRHB]
,P.[AB] as [AB-vsRHB]
,P.[R] as [R-vsRHB]
,P.[H] as [H-vsRHB]
,P.[2B] as [2B-vsRHB]
,P.[3B] as [3B-vsRHB]
,P.[HR] as [HR-vsRHB]
,P.[SB] as [SB-vsRHB]
,P.[CS] as [CS-vsRHB]
,P.[BB] as [BB-vsRHB]
,P.[SO] as [SO-vsRHB]
,P.[SO/W] as [SO/W-vsRHB]
,P.[BA] as [BA-vsRHB]
,P.[OBP] as [OBP-vsRHB]
,P.[SLG] as [SLG-vsRHB]
,P.[OPS] as [OPS-vsRHB]
,P.[TB] as [TB-vsRHB]
,P.[GDP] as [GDP-vsRHB]
,P.[HBP] as [HBP-vsRHB]
,P.[SH] as [SH-vsRHB]
,P.[SF] as [SF-vsRHB]
,P.[IBB] as [IBB-vsRHB]
,P.[ROE] as [ROE-vsRHB]
,P.[BAbip] as [BAbip-vsRHB]
,P.[tOPS+] as [tOPS+-vsRHB]
,P.[sOPS+] as [sOPS+-vsRHB]
From #PLAYERS_WITH_TOT PWT
inner join STANDARD_PITCHING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_PITCHING_DATA P
on S.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
and S.Lg = 'MLB'
and Split = 'vs RHB'
) RHB
on LHB.Player_CDE = RHB.Player_CDE


/**********************************************************/

/*****/

Select COALESCE(LHB.Player_CDE,RHB.Player_CDE) as Player_CDE
,COALESCE(LHB.Tm,RHB.Tm) as Tm
,COALESCE(LHB.Year,RHB.Year) as Year
,COALESCE(LHB.Lg,RHB.Lg) as Lg
,LHB.[G-vsLHB]
,LHB.[PA-vsLHB]
,LHB.[AB-vsLHB]
,LHB.[R-vsLHB]
,LHB.[H-vsLHB]
,LHB.[2B-vsLHB]
,LHB.[3B-vsLHB]
,LHB.[HR-vsLHB]
,LHB.[SB-vsLHB]
,LHB.[CS-vsLHB]
,LHB.[BB-vsLHB]
,LHB.[SO-vsLHB]
,LHB.[SO/W-vsLHB]
,LHB.[BA-vsLHB]
,LHB.[OBP-vsLHB]
,LHB.[SLG-vsLHB]
,LHB.[OPS-vsLHB]
,LHB.[TB-vsLHB]
,LHB.[GDP-vsLHB]
,LHB.[HBP-vsLHB]
,LHB.[SH-vsLHB]
,LHB.[SF-vsLHB]
,LHB.[IBB-vsLHB]
,LHB.[ROE-vsLHB]
,LHB.[BAbip-vsLHB]
,LHB.[tOPS+-vsLHB]
,LHB.[sOPS+-vsLHB]
,RHB.[G-vsRHB]
,RHB.[PA-vsRHB]
,RHB.[AB-vsRHB]
,RHB.[R-vsRHB]
,RHB.[H-vsRHB]
,RHB.[2B-vsRHB]
,RHB.[3B-vsRHB]
,RHB.[HR-vsRHB]
,RHB.[SB-vsRHB]
,RHB.[CS-vsRHB]
,RHB.[BB-vsRHB]
,RHB.[SO-vsRHB]
,RHB.[SO/W-vsRHB]
,RHB.[BA-vsRHB]
,RHB.[OBP-vsRHB]
,RHB.[SLG-vsRHB]
,RHB.[OPS-vsRHB]
,RHB.[TB-vsRHB]
,RHB.[GDP-vsRHB]
,RHB.[HBP-vsRHB]
,RHB.[SH-vsRHB]
,RHB.[SF-vsRHB]
,RHB.[IBB-vsRHB]
,RHB.[ROE-vsRHB]
,RHB.[BAbip-vsRHB]
,RHB.[tOPS+-vsRHB]
,RHB.[sOPS+-vsRHB]
Into #TOT_WITHOUT_SPLIT_DATA
From
(
Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsLHB]
,P.[PA] as [PA-vsLHB]
,P.[AB] as [AB-vsLHB]
,P.[R] as [R-vsLHB]
,P.[H] as [H-vsLHB]
,P.[2B] as [2B-vsLHB]
,P.[3B] as [3B-vsLHB]
,P.[HR] as [HR-vsLHB]
,P.[SB] as [SB-vsLHB]
,P.[CS] as [CS-vsLHB]
,P.[BB] as [BB-vsLHB]
,P.[SO] as [SO-vsLHB]
,P.[SO/W] as [SO/W-vsLHB]
,P.[BA] as [BA-vsLHB]
,P.[OBP] as [OBP-vsLHB]
,P.[SLG] as [SLG-vsLHB]
,P.[OPS] as [OPS-vsLHB]
,P.[TB] as [TB-vsLHB]
,P.[GDP] as [GDP-vsLHB]
,P.[HBP] as [HBP-vsLHB]
,P.[SH] as [SH-vsLHB]
,P.[SF] as [SF-vsLHB]
,P.[IBB] as [IBB-vsLHB]
,P.[ROE] as [ROE-vsLHB]
,P.[BAbip] as [BAbip-vsLHB]
,P.[tOPS+] as [tOPS+-vsLHB]
,P.[sOPS+] as [sOPS+-vsLHB]
From #PLAYERS_WITHOUT_TOT PWT
inner join STANDARD_PITCHING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_PITCHING_DATA P
on S.Player_CDE = P.Player_CDE
Where Split = 'vs LHB'
) LHB
full outer join
(

Select S.Player_CDE
,S.Tm
,S.Year
,S.Lg
,P.[G] as [G-vsRHB]
,P.[PA] as [PA-vsRHB]
,P.[AB] as [AB-vsRHB]
,P.[R] as [R-vsRHB]
,P.[H] as [H-vsRHB]
,P.[2B] as [2B-vsRHB]
,P.[3B] as [3B-vsRHB]
,P.[HR] as [HR-vsRHB]
,P.[SB] as [SB-vsRHB]
,P.[CS] as [CS-vsRHB]
,P.[BB] as [BB-vsRHB]
,P.[SO] as [SO-vsRHB]
,P.[SO/W] as [SO/W-vsRHB]
,P.[BA] as [BA-vsRHB]
,P.[OBP] as [OBP-vsRHB]
,P.[SLG] as [SLG-vsRHB]
,P.[OPS] as [OPS-vsRHB]
,P.[TB] as [TB-vsRHB]
,P.[GDP] as [GDP-vsRHB]
,P.[HBP] as [HBP-vsRHB]
,P.[SH] as [SH-vsRHB]
,P.[SF] as [SF-vsRHB]
,P.[IBB] as [IBB-vsRHB]
,P.[ROE] as [ROE-vsRHB]
,P.[BAbip] as [BAbip-vsRHB]
,P.[tOPS+] as [tOPS+-vsRHB]
,P.[sOPS+] as [sOPS+-vsRHB]
From #PLAYERS_WITHOUT_TOT PWT
inner join STANDARD_PITCHING_DATA S
on PWT.Player_CDE = S.Player_CDE
inner join PLATOON_SPLITS_PITCHING_DATA P
on S.Player_CDE = P.Player_CDE
Where Split = 'vs RHB'
) RHB
on LHB.Player_CDE = RHB.Player_CDE


Select S.[Rk]
,S.[Name]
,S.[Year]
,S.[Age]
,S.[Tm]
,S.[Lg]
,S.[W]
,S.[L]
,S.[W-L%]
,S.[ERA]
,S.[G]
,S.[GS]
,S.[GF]
,S.[CG]
,S.[SHO]
,S.[SV]
,S.[IP]
,S.[H]
,S.[R]
,S.[ER]
,S.[HR]
,S.[BB]
,S.[IBB]
,S.[SO]
,S.[HBP]
,S.[BK]
,S.[WP]
,S.[BF]
,S.[ERA+]
,S.[FIP]
,S.[WHIP]
,S.[H9]
,S.[HR9]
,S.[BB9]
,S.[SO9]
,S.[SO/W]
,S.[Player_CDE]
,A.[G-vsLHB]
,A.[PA-vsLHB]
,A.[AB-vsLHB]
,A.[R-vsLHB]
,A.[H-vsLHB]
,A.[2B-vsLHB]
,A.[3B-vsLHB]
,A.[HR-vsLHB]
,A.[SB-vsLHB]
,A.[CS-vsLHB]
,A.[BB-vsLHB]
,A.[SO-vsLHB]
,A.[SO/W-vsLHB]
,A.[BA-vsLHB]
,A.[OBP-vsLHB]
,A.[SLG-vsLHB]
,A.[OPS-vsLHB]
,A.[TB-vsLHB]
,A.[GDP-vsLHB]
,A.[HBP-vsLHB]
,A.[SH-vsLHB]
,A.[SF-vsLHB]
,A.[IBB-vsLHB]
,A.[ROE-vsLHB]
,A.[BAbip-vsLHB]
,A.[tOPS+-vsLHB]
,A.[sOPS+-vsLHB]
,A.[G-vsRHB]
,A.[PA-vsRHB]
,A.[AB-vsRHB]
,A.[R-vsRHB]
,A.[H-vsRHB]
,A.[2B-vsRHB]
,A.[3B-vsRHB]
,A.[HR-vsRHB]
,A.[SB-vsRHB]
,A.[CS-vsRHB]
,A.[BB-vsRHB]
,A.[SO-vsRHB]
,A.[SO/W-vsRHB]
,A.[BA-vsRHB]
,A.[OBP-vsRHB]
,A.[SLG-vsRHB]
,A.[OPS-vsRHB]
,A.[TB-vsRHB]
,A.[GDP-vsRHB]
,A.[HBP-vsRHB]
,A.[SH-vsRHB]
,A.[SF-vsRHB]
,A.[IBB-vsRHB]
,A.[ROE-vsRHB]
,A.[BAbip-vsRHB]
,A.[tOPS+-vsRHB]
,A.[sOPS+-vsRHB]
Into #STRATO_PITCHING_DATA
From STANDARD_PITCHING_DATA S
left join (
Select *
From #TOT_SPLIT_DATA
UNION ALL
Select *
From #TOT_WITHOUT_SPLIT_DATA
) A
on S.Player_CDE = A.Player_CDE
and S.Year = A.Year
and S.Tm = A.Tm
and S.Lg = A.Lg
Order By Rk

INSERT INTO STRATO_PITCHING_DATA Select * From #STRATO_PITCHING_DATA
RETURN 0

CREATE TABLE [dbo].[PLATOON_SPLITS_BATTING_DATA](
	[Split] varchar(20) NULL,
	[G] TINYINT NULL,
	[GS] TINYINT NULL,
	[PA] SMALLINT NULL,
	[AB] SMALLINT NULL,
	[R] SMALLINT NULL,
	[H] SMALLINT NULL,
	[2B] SMALLINT NULL,
	[3B] TINYINT NULL,
	[HR] TINYINT NULL,
	[RBI] SMALLINT NULL,
	[SB] SMALLINT NULL,
	[CS] TINYINT NULL,
	[BB] SMALLINT NULL,
	[SO] SMALLINT NULL,
	[BA] NUMERIC(9, 3) NULL,
	[OBP] NUMERIC(9, 3) NULL,
	[SLG] NUMERIC(9, 3) NULL,
	[OPS] NUMERIC(9, 3) NULL,
	[TB] SMALLINT NULL,
	[GDP] SMALLINT NULL,
	[HBP] TINYINT NULL,
	[SH] TINYINT NULL,
	[SF] TINYINT NULL,
	[IBB] TINYINT NULL,
	[ROE] TINYINT NULL,
	[BAbip] NUMERIC(9, 3) NULL,
	[tOPS+] SMALLINT NULL,
	[sOPS+] SMALLINT NULL,
	[Player_CDE] varchar(15) NULL,
	[LevelOfDeatil_DSC] varchar(40) NULL,
	[Load_DTM] DATETIME NULL,
	[Year] SMALLINT NULL
)
GO

CREATE TABLE [dbo].[PLATOON_SPLITS_PITCHING_DATA](
	[Split] [varchar](20) NULL,
	[G] SMALLINT NULL,
	[PA] SMALLINT NULL,
	[AB] SMALLINT NULL,
	[R] SMALLINT NULL,
	[H] SMALLINT NULL,
	[2B] SMALLINT NULL,
	[3B] TINYINT NULL,
	[HR] TINYINT NULL,
	[SB] TINYINT NULL,
	[CS] TINYINT NULL,
	[BB] SMALLINT NULL,
	[SO] SMALLINT NULL,
	[SO/W] NUMERIC(9, 2) NULL,
	[BA] NUMERIC(9, 3) NULL,
	[OBP] NUMERIC(9, 3) NULL,
	[SLG] NUMERIC(9, 3) NULL,
	[OPS] NUMERIC(9, 3) NULL,
	[TB] SMALLINT NULL,
	[GDP] SMALLINT NULL,
	[HBP] SMALLINT NULL,
	[SH] SMALLINT NULL,
	[SF] SMALLINT NULL,
	[IBB] SMALLINT NULL,
	[ROE] SMALLINT NULL,
	[BAbip] NUMERIC(9, 3) NULL,
	[tOPS+] SMALLINT NULL,
	[sOPS+] SMALLINT NULL,
	[Player_CDE] varchar(15) NULL,
	[LevelOfDeatil_DSC] varchar(40) NULL,
	[Load_DTM] DATETIME NULL,
	[Year] SMALLINT NULL
)
GO

CREATE TABLE [dbo].[STANDARD_BATTING_DATA](
	[Rk] SMALLINT NULL,
	[Name] varchar(50) NULL,
	[Age] TINYINT NULL,
	[Tm] varchar(5) NULL,
	[Lg] varchar(5) NULL,
	[G] SMALLINT NULL,
	[PA] SMALLINT NULL,
	[AB] SMALLINT NULL,
	[R] SMALLINT NULL,
	[H] SMALLINT NULL,
	[2B] SMALLINT NULL,
	[3B] TINYINT NULL,
	[HR] TINYINT NULL,
	[RBI] SMALLINT NULL,
	[SB] SMALLINT NULL,
	[CS] SMALLINT NULL,
	[BB] SMALLINT NULL,
	[SO] SMALLINT NULL,
	[BA] NUMERIC(9, 3) NULL,
	[OBP] NUMERIC(9, 3) NULL,
	[SLG] NUMERIC(9, 3) NULL,
	[OPS] NUMERIC(9, 3) NULL,
	[OPS+] SMALLINT NULL,
	[TB] SMALLINT NULL,
	[GDP] SMALLINT NULL,
	[HBP] SMALLINT NULL,
	[SH] SMALLINT NULL,
	[SF] SMALLINT NULL,
	[IBB] SMALLINT NULL,
	[Pos Summary] varchar(30) NULL,
	[Player_CDE] varchar(15) NULL,
	[LevelOfDeatil_DSC] varchar(40) NULL,
	[Load_DTM] DATETIME NULL,
	[Year] SMALLINT NULL
)
GO;
CREATE CLUSTERED INDEX [CI_Year_Player_CDE_Tm_Lg] on [dbo].[STANDARD_BATTING_DATA] ([Year] DESC,[Player_CDE] ASC,[Tm] ASC,[Lg] ASC) WITH(DATA_COMPRESSION=PAGE);
GO;

CREATE TABLE [dbo].[STANDARD_PITCHING_DATA](
	[Rk] SMALLINT NULL,
	[Name] varchar(50) NULL,
	[Age] TINYINT NULL,
	[Tm] varchar(5) NULL,
	[Lg] varchar(5) NULL,
	[W] TINYINT NULL,
	[L] TINYINT NULL,
	[W-L%] NUMERIC(9, 3) NULL,
	[ERA] NUMERIC(9, 2) NULL,
	[G] SMALLINT NULL,
	[GS] SMALLINT NULL,
	[GF] SMALLINT NULL,
	[CG] SMALLINT NULL,
	[SHO] SMALLINT NULL,
	[SV] TINYINT NULL,
	[IP] NUMERIC(9, 1) NULL,
	[H] SMALLINT NULL,
	[R] SMALLINT NULL,
	[ER] SMALLINT NULL,
	[HR] SMALLINT NULL,
	[BB] SMALLINT NULL,
	[IBB] SMALLINT NULL,
	[SO] SMALLINT NULL,
	[HBP] SMALLINT NULL,
	[BK] SMALLINT NULL,
	[WP] SMALLINT NULL,
	[BF] SMALLINT NULL,
	[ERA+] SMALLINT NULL,
	[FIP] NUMERIC(9, 2) NULL,
	[WHIP] NUMERIC(9, 3) NULL,
	[H9] NUMERIC(9, 1) NULL,
	[HR9] NUMERIC(9, 1) NULL,
	[BB9] NUMERIC(9, 1) NULL,
	[SO9] NUMERIC(9, 1) NULL,
	[SO/W] NUMERIC(9, 2) NULL,
	[Player_CDE] varchar(15) NULL,
	[LevelOfDeatil_DSC] varchar(40) NULL,
	[Load_DTM] DATETIME NULL,
	[Year] SMALLINT NULL
)
GO;
CREATE CLUSTERED INDEX [CI_Year_Player_CDE_Tm_Lg] on [dbo].[STANDARD_PITCHING_DATA] ([Year] DESC,[Player_CDE] ASC,[Tm] ASC,[Lg] ASC) WITH(DATA_COMPRESSION=PAGE);
GO;

CREATE TABLE [dbo].[STRATO_BATTING_DATA](
	[Rk] smallint NULL,
	[Name] varchar(50) NULL,
	[Year] smallint NULL,
	[Age] tinyint NULL,
	[Tm] varchar(5) NULL,
	[Lg] varchar(5) NULL,
	[G] smallint NULL,
	[PA] smallint NULL,
	[AB] smallint NULL,
	[R] smallint NULL,
	[H] smallint NULL,
	[2B] smallint NULL,
	[3B] tinyint NULL,
	[HR] tinyint NULL,
	[RBI] smallint NULL,
	[SB] smallint NULL,
	[CS] smallint NULL,
	[BB] smallint NULL,
	[SO] smallint NULL,
	[BA] numeric(9, 3) NULL,
	[OBP] numeric(9, 3) NULL,
	[SLG] numeric(9, 3) NULL,
	[OPS] numeric(9, 3) NULL,
	[OPS+] smallint NULL,
	[TB] smallint NULL,
	[GDP] smallint NULL,
	[HBP] smallint NULL,
	[SH] smallint NULL,
	[SF] smallint NULL,
	[IBB] smallint NULL,
	[Pos Summary] varchar(30) NULL,
	[Player_CDE] varchar(15) NULL,
	[G-vsLHP] tinyint NULL,
	[GS-vsLHP] tinyint NULL,
	[PA-vsLHP] smallint NULL,
	[AB-vsLHP] smallint NULL,
	[R-vsLHP] smallint NULL,
	[H-vsLHP] smallint NULL,
	[2B-vsLHP] smallint NULL,
	[3B-vsLHP] tinyint NULL,
	[HR-vsLHP] tinyint NULL,
	[RBI-vsLHP] smallint NULL,
	[SB-vsLHP] smallint NULL,
	[CS-vsLHP] tinyint NULL,
	[BB-vsLHP] smallint NULL,
	[SO-vsLHP] smallint NULL,
	[BA-vsLHP] numeric(9, 3) NULL,
	[OBP-vsLHP] numeric(9, 3) NULL,
	[SLG-vsLHP] numeric(9, 3) NULL,
	[OPS-vsLHP] numeric(9, 3) NULL,
	[TB-vsLHP] smallint NULL,
	[GDP-vsLHP] smallint NULL,
	[HBP-vsLHP] tinyint NULL,
	[SH-vsLHP] tinyint NULL,
	[SF-vsLHP] tinyint NULL,
	[IBB-vsLHP] tinyint NULL,
	[ROE-vsLHP] tinyint NULL,
	[BAbip-vsLHP] numeric(9, 3) NULL,
	[tOPS+-vsLHP] smallint NULL,
	[sOPS+-vsLHP] smallint NULL,
	[G-vsRHP] tinyint NULL,
	[GS-vsRHP] tinyint NULL,
	[PA-vsRHP] smallint NULL,
	[AB-vsRHP] smallint NULL,
	[R-vsRHP] smallint NULL,
	[H-vsRHP] smallint NULL,
	[2B-vsRHP] smallint NULL,
	[3B-vsRHP] tinyint NULL,
	[HR-vsRHP] tinyint NULL,
	[RBI-vsRHP] smallint NULL,
	[SB-vsRHP] smallint NULL,
	[CS-vsRHP] tinyint NULL,
	[BB-vsRHP] smallint NULL,
	[SO-vsRHP] smallint NULL,
	[BA-vsRHP] numeric(9, 3) NULL,
	[OBP-vsRHP] numeric(9, 3) NULL,
	[SLG-vsRHP] numeric(9, 3) NULL,
	[OPS-vsRHP] numeric(9, 3) NULL,
	[TB-vsRHP] smallint NULL,
	[GDP-vsRHP] smallint NULL,
	[HBP-vsRHP] tinyint NULL,
	[SH-vsRHP] tinyint NULL,
	[SF-vsRHP] tinyint NULL,
	[IBB-vsRHP] tinyint NULL,
	[ROE-vsRHP] tinyint NULL,
	[BAbip-vsRHP] numeric(9, 3) NULL,
	[tOPS+-vsRHP] smallint NULL,
	[sOPS+-vsRHP] smallint NULL
)
GO;
CREATE CLUSTERED INDEX [CI_YEAR] ON [dbo].[STRATO_BATTING_DATA] ([Year] ASC) WITH(DATA_COMPRESSION=PAGE);
GO;

CREATE TABLE [dbo].[STRATO_PITCHING_DATA](
	[Rk] smallint NULL,
	[Name] varchar(50) NULL,
	[Year] smallint NULL,
	[Age] tinyint NULL,
	[Tm] varchar(5) NULL,
	[Lg] varchar(5) NULL,
	[W] tinyint NULL,
	[L] tinyint NULL,
	[W-L%] numeric(9, 3) NULL,
	[ERA] numeric(9, 2) NULL,
	[G] smallint NULL,
	[GS] smallint NULL,
	[GF] smallint NULL,
	[CG] smallint NULL,
	[SHO] smallint NULL,
	[SV] tinyint NULL,
	[IP] numeric(9, 1) NULL,
	[H] smallint NULL,
	[R] smallint NULL,
	[ER] smallint NULL,
	[HR] smallint NULL,
	[BB] smallint NULL,
	[IBB] smallint NULL,
	[SO] smallint NULL,
	[HBP] smallint NULL,
	[BK] smallint NULL,
	[WP] smallint NULL,
	[BF] smallint NULL,
	[ERA+] smallint NULL,
	[FIP] numeric(9, 2) NULL,
	[WHIP] numeric(9, 3) NULL,
	[H9] numeric(9, 1) NULL,
	[HR9] numeric(9, 1) NULL,
	[BB9] numeric(9, 1) NULL,
	[SO9] numeric(9, 1) NULL,
	[SO/W] numeric(9, 2) NULL,
	[Player_CDE] varchar(15) NULL,
	[G-vsLHB] smallint NULL,
	[PA-vsLHB] smallint NULL,
	[AB-vsLHB] smallint NULL,
	[R-vsLHB] smallint NULL,
	[H-vsLHB] smallint NULL,
	[2B-vsLHB] smallint NULL,
	[3B-vsLHB] tinyint NULL,
	[HR-vsLHB] tinyint NULL,
	[SB-vsLHB] tinyint NULL,
	[CS-vsLHB] tinyint NULL,
	[BB-vsLHB] smallint NULL,
	[SO-vsLHB] smallint NULL,
	[SO/W-vsLHB] numeric(9, 2) NULL,
	[BA-vsLHB] numeric(9, 3) NULL,
	[OBP-vsLHB] numeric(9, 3) NULL,
	[SLG-vsLHB] numeric(9, 3) NULL,
	[OPS-vsLHB] numeric(9, 3) NULL,
	[TB-vsLHB] smallint NULL,
	[GDP-vsLHB] smallint NULL,
	[HBP-vsLHB] smallint NULL,
	[SH-vsLHB] smallint NULL,
	[SF-vsLHB] smallint NULL,
	[IBB-vsLHB] smallint NULL,
	[ROE-vsLHB] smallint NULL,
	[BAbip-vsLHB] numeric(9, 3) NULL,
	[tOPS+-vsLHB] smallint NULL,
	[sOPS+-vsLHB] smallint NULL,
	[G-vsRHB] smallint NULL,
	[PA-vsRHB] smallint NULL,
	[AB-vsRHB] smallint NULL,
	[R-vsRHB] smallint NULL,
	[H-vsRHB] smallint NULL,
	[2B-vsRHB] smallint NULL,
	[3B-vsRHB] tinyint NULL,
	[HR-vsRHB] tinyint NULL,
	[SB-vsRHB] tinyint NULL,
	[CS-vsRHB] tinyint NULL,
	[BB-vsRHB] smallint NULL,
	[SO-vsRHB] smallint NULL,
	[SO/W-vsRHB] numeric(9, 2) NULL,
	[BA-vsRHB] numeric(9, 3) NULL,
	[OBP-vsRHB] numeric(9, 3) NULL,
	[SLG-vsRHB] numeric(9, 3) NULL,
	[OPS-vsRHB] numeric(9, 3) NULL,
	[TB-vsRHB] smallint NULL,
	[GDP-vsRHB] smallint NULL,
	[HBP-vsRHB] smallint NULL,
	[SH-vsRHB] smallint NULL,
	[SF-vsRHB] smallint NULL,
	[IBB-vsRHB] smallint NULL,
	[ROE-vsRHB] smallint NULL,
	[BAbip-vsRHB] numeric(9, 3) NULL,
	[tOPS+-vsRHB] smallint NULL,
	[sOPS+-vsRHB] smallint NULL
)
GO;
CREATE CLUSTERED INDEX [CI_Year] on [dbo].[STRATO_PITCHING_DATA] ([Year] ASC) WITH(DATA_COMPRESSION=PAGE);
GO;


CREATE VIEW [dbo].[vw_STRATO_BATTING_DATA]
AS SELECT 
[Rk]
,[Name]
,[Year]
,[Age]
,[Tm]
,[Lg]
,[G]
,[PA]
,[AB]
,[R]
,[H]
,[2B]
,[3B]
,[HR]
,[RBI]
,[SB]
,[CS]
,[BB]
,[SO]
,[BA]
,[OBP]
,[SLG]
,[OPS]
,[OPS+]
,[TB]
,[GDP]
,[HBP]
,[SH]
,[SF]
,[IBB]
,[Pos Summary]
,[Player_CDE]
,[G-vsLHP]
,[GS-vsLHP]
,[PA-vsLHP]
,[AB-vsLHP]
,[R-vsLHP]
,[H-vsLHP]
,[2B-vsLHP]
,[3B-vsLHP]
,[HR-vsLHP]
,[RBI-vsLHP]
,[SB-vsLHP]
,[CS-vsLHP]
,[BB-vsLHP]
,[SO-vsLHP]
,[BA-vsLHP]
,[OBP-vsLHP]
,[SLG-vsLHP]
,[OPS-vsLHP]
,[TB-vsLHP]
,[GDP-vsLHP]
,[HBP-vsLHP]
,[SH-vsLHP]
,[SF-vsLHP]
,[IBB-vsLHP]
,[ROE-vsLHP]
,[BAbip-vsLHP]
,[tOPS+-vsLHP]
,[sOPS+-vsLHP]
,[G-vsRHP]
,[GS-vsRHP]
,[PA-vsRHP]
,[AB-vsRHP]
,[R-vsRHP]
,[H-vsRHP]
,[2B-vsRHP]
,[3B-vsRHP]
,[HR-vsRHP]
,[RBI-vsRHP]
,[SB-vsRHP]
,[CS-vsRHP]
,[BB-vsRHP]
,[SO-vsRHP]
,[BA-vsRHP]
,[OBP-vsRHP]
,[SLG-vsRHP]
,[OPS-vsRHP]
,[TB-vsRHP]
,[GDP-vsRHP]
,[HBP-vsRHP]
,[SH-vsRHP]
,[SF-vsRHP]
,[IBB-vsRHP]
,[ROE-vsRHP]
,[BAbip-vsRHP]
,[tOPS+-vsRHP]
,[sOPS+-vsRHP]
FROM [dbo].[STRATO_BATTING_DATA]


CREATE VIEW [dbo].[vw_STRATO_PITCHING_DATA]
AS SELECT 
[Rk]
,[Name]
,[Year]
,[Age]
,[Tm]
,[Lg]
,[W]
,[L]
,[W-L%]
,[ERA]
,[G]
,[GS]
,[GF]
,[CG]
,[SHO]
,[SV]
,[IP]
,[H]
,[R]
,[ER]
,[HR]
,[BB]
,[IBB]
,[SO]
,[HBP]
,[BK]
,[WP]
,[BF]
,[ERA+]
,[FIP]
,[WHIP]
,[H9]
,[HR9]
,[BB9]
,[SO9]
,[SO/W]
,[Player_CDE]
,[G-vsLHB]
,[PA-vsLHB]
,[AB-vsLHB]
,[R-vsLHB]
,[H-vsLHB]
,[2B-vsLHB]
,[3B-vsLHB]
,[HR-vsLHB]
,[SB-vsLHB]
,[CS-vsLHB]
,[BB-vsLHB]
,[SO-vsLHB]
,[SO/W-vsLHB]
,[BA-vsLHB]
,[OBP-vsLHB]
,[SLG-vsLHB]
,[OPS-vsLHB]
,[TB-vsLHB]
,[GDP-vsLHB]
,[HBP-vsLHB]
,[SH-vsLHB]
,[SF-vsLHB]
,[IBB-vsLHB]
,[ROE-vsLHB]
,[BAbip-vsLHB]
,[tOPS+-vsLHB]
,[sOPS+-vsLHB]
,[G-vsRHB]
,[PA-vsRHB]
,[AB-vsRHB]
,[R-vsRHB]
,[H-vsRHB]
,[2B-vsRHB]
,[3B-vsRHB]
,[HR-vsRHB]
,[SB-vsRHB]
,[CS-vsRHB]
,[BB-vsRHB]
,[SO-vsRHB]
,[SO/W-vsRHB]
,[BA-vsRHB]
,[OBP-vsRHB]
,[SLG-vsRHB]
,[OPS-vsRHB]
,[TB-vsRHB]
,[GDP-vsRHB]
,[HBP-vsRHB]
,[SH-vsRHB]
,[SF-vsRHB]
,[IBB-vsRHB]
,[ROE-vsRHB]
,[BAbip-vsRHB]
,[tOPS+-vsRHB]
,[sOPS+-vsRHB]
FROM [STRATO_PITCHING_DATA]
