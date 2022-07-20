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