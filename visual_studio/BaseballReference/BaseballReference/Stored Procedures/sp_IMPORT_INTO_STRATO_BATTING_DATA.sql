CREATE PROCEDURE [dbo].[sp_IMPORT_INTO_STRATO_BATTING_DATA]

AS


IF OBJECT_ID('Tempdb..#PLAYERS_WITH_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITH_TOT
IF OBJECT_ID('Tempdb..#PLAYERS_WITHOUT_TOT') IS NOT NULL DROP TABLE #PLAYERS_WITHOUT_TOT
IF OBJECT_ID('Tempdb..#TOT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#TOT_WITHOUT_SPLIT_DATA') IS NOT NULL DROP TABLE #TOT_WITHOUT_SPLIT_DATA
IF OBJECT_ID('Tempdb..#STRATO_BATTING_DATA') IS NOT NULL DROP TABLE #STRATO_BATTING_DATA


/* Players with a total Record*/
Select Player_CDE
,Min(Rk) as Rk
,'Y' as TotalRecord_IND
Into #PLAYERS_WITH_TOT
From STANDARD_BATTING_DATA
Where Tm = 'TOT'
Group By Player_CDE


/* Players without a total Record*/
Select S.Player_CDE
,Min(S.Rk) as Rk
,'N' as TotalRecord_IND
Into #PLAYERS_WITHOUT_TOT
From STANDARD_BATTING_DATA S
left join #PLAYERS_WITH_TOT P
on S.Player_CDE = P.Player_CDE
Where P.Player_CDE is null
Group By S.Player_CDE


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
and PWT.Rk = S.Rk
inner join PLATOON_SPLITS_BATTING_DATA P
on PWT.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
and P.Split = 'vs LHP'
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
and PWT.Rk = S.Rk
inner join PLATOON_SPLITS_BATTING_DATA P
on S.Player_CDE = P.Player_CDE
Where S.Tm = 'TOT'
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
