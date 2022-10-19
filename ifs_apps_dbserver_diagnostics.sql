--***************************************************************************************
--***************************************************************************************
--                               DO NOT EDIT THIS SCRIPT  
--
--                                  RUN USING SQLPLUS
--   THE SCRIPT WILL PROMPT FOR NEEDED ORACLE CONNECT STRINGS FOR IFSAPPOWNER AND SYS
--***************************************************************************************
--***************************************************************************************
set feedback off;
set head on; 
set linesize 145; 
set pagesize 10000;
set serveroutput on size 1000000; 
set tab off;
set termout on;
set time off;
set timing off;
set trimspool on;
set verify on;
set echo on; 
--
--   DO NOT EDIT THIS SCRIPT 
--   RUN USING SQLPLUS
--   THE SCRIPT WILL PROMPT FOR CONNECT STRINGS FOR IFSAPPOWNER AND SYS AND IFSINFO
--
-- Some queries will need to be run as SYS 
-- and some as IFS APPLICATIONS OWNER
--
-- To gather needed information we will need to connect/reconnect 
-- as different users during this script run.
--
-- Enter connect string in order to log in 
-- as IFS Applications Owner (typically IFSAPP)
--
-- Must be in format: user/password@sid
--
--  e.g.,   "IFSAPP/<IFSAPP_password>@<sid>"     
--
define ifsappowner_connect = '&&ifsappowner_connect_string';
--
-- **************************************************************************************
--
connect &&ifsappowner_connect;
--
show user; 
 
-- "SHOW USER" (above) should show "USER IS "<IFS Applications Owner ID>"
-- If above connect did not work, cancel script, exit SQL*Plus (Control-C)
-- and restart SQL*Plus and the script
-- **********************************************
-- Next enter connect string in order to log in as SYS
-- Must be in format: user/password@sid as sysdba
--
--  e.g.,   "SYS/<SYS_password>@<sid> as sysdba"  
--
--   (For older versions of Oracle the "as sysdba" may not be valid)
--
define sys_connect = '&&sys_connect_string';
--
-- **************************************************************************************
--
connect &&sys_connect;
--
--
show user;  
   
-- "SHOW USER" (above) should show "USER IS SYS" 
-- If above connect did not work, cancel script, exit SQL*Plus (Control-C)
-- and restart SQL*Plus and the script
-- **********************************************
-- Next enter connect string in order to log in as the IAL USER ID (typically IFSINFO)
-- Must be in format: user/password@sid
--
--  e.g.,   "IFSINFO/<IFSINFO_password>@<sid>"  
--
define info_connect = '&&info_connect_string';
--
-- **************************************************************************************
--
connect &&info_connect;
--
--
show user;  
   
-- "SHOW USER" (above) should show "USER IS "<IAL USER ID>"
-- If above connect did not work, cancel script, exit SQL*Plus (Control-C)
-- and restart SQL*Plus and the script

-- **********************************************
-- Next enter your IFS Applications Owner ID.
--  This is typically IFSAPP, but your installation may be different
--
define ifsappowner___ = &&ifs_applications_owner;
--
-- 
--
-- In order to verify above connection as SYS, ask user to enter appowner.  
-- Ignore entry.  Parse ifsappowner_connect string to get ifsappowner, 
-- entered earlier, which is already proven correct by login checks done above.
--
-- Connect as sys in case IFSINFO is not entered right
connect &&sys_connect;
--
column dchar new_value ifsappowner;
-- parse App Owner from appowner connect string entered earlier
select substr('&&ifsappowner_connect', 1, instr('&&ifsappowner_connect', '/')-1) dchar 
  from dual;
--select '' &ifsappowner from dual;
--
--
-- get Appowner into upper case for use in queries below thus avoiding 
-- runtime upper case conversion and negative performance impact
--
var ifsappowner_uc varchar2(20);
exec :ifsappowner_uc := upper('&&ifsappowner');
-- 
--
--  Define variable for IFSINFO (IALUSER)
column ifsinfo_user new_value ifsinfo2;
select upper(value) ifsinfo_user from &&ifsappowner..fnd_setting_tab where parameter = 'IAL_USER';
var IFSINFO_UC varchar2(20);
exec :IFSINFO_UC := upper('&&ifsinfo2');
-- name spool file
--  ============================================================
--  Format spool file name with dbname and currdate
--  ============================================================
connect &&sys_connect;
show user;
--
column dbname_ new_value dbname;
select chr(39) || name || chr(39) dbname_ from v$database;
column dcol new_value currdate; 
select chr(39) || to_char(sysdate,'YYYY_MM_DD__HH24_MI_SS') || chr(39) dcol from dual;
undefine spoolname;
column dbspool new_value spoolname;
select  'ifs_apps_dbserver_diagnostics_' || &dbname || '_' ||  &currdate dbspool  from dual;
--
set echo off; 
spool &&spoolname;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Display variables, test connections
PROMPT       List user variables values
PROMPT       ============================================================
--define ifsappowner;
--define spoolname;
--
--  List bind variables values
column IFSAPPOWNER_UC format a14;
column IFSINFO_UC     format a14;
PROMPT       Appowner is:
print IFSAPPOWNER_UC;
PROMPT       IFSINFO user is:
print IFSINFO_UC;
--
PROMPT       Test connect strings provided for Appowner, IFSINFO, SYS
connect &&ifsappowner_connect;
show user;
--
connect &&info_connect;
show user;
--
connect &&sys_connect;
show user;
PROMPT     
PROMPT       ============================================================
PROMPT  
PROMPT       ifs_apps_dbserver_diagnostics.sql  V 2.83 2019-03-16
PROMPT     
PROMPT       Created by:  STMAUS
PROMPT     
PROMPT       Set 1 Database version, settings, space usage
PROMPT     
PROMPT       Query 1a - Company name
PROMPT       Query 1b - Query various v$ tables
PROMPT       Query 1c - User Account info
PROMPT       Query 1d - Not used
PROMPT       Query 1e - Get database character set information - set variable query1e_extended=Y to run extended diagnostics
PROMPT       Query 1f - List PL/SQL Code Optimization Level and nls_length_semantics value
PROMPT       Query 1g - Show tablespaces total space used, allocated, free, percent
PROMPT       Query 1h - Show table spaces and data files
PROMPT       Query 1i - Show space usage of segments by owner
PROMPT       Query 1j - Show largest objects by database segments use by Appowner/others
PROMPT       Query 1k -;
PROMPT       Query 1l - Show extent usage - > 500 extents for a segment 
PROMPT       Query 1m - Show tables/indexes not analyzed for statistics 
PROMPT       Query 1n - Show top 100 tables with empty space (estimated) - can extend to give resize table names
PROMPT       Query 1o - Show top 100 tables by number of data rows
PROMPT       Query 1p - Check for indexes marked by Oracle as corrupt
PROMPT       Query 1q - Show database links defined 
PROMPT       Query 1r - Show Oracle text status
PROMPT       Query 1s - Show table name with mixed cases
PROMPT       Query 1t - Show directories defined
PROMPT       Query 1u - Show ACL related data
PROMPT       Query 1v - Show Oracle Auditing related data
PROMPT       
PROMPT       Set 2 IFS Apps Objects
PROMPT     
PROMPT       Query 2a - Object Count - all Oracle users
PROMPT       Query 2b - List invalid database objects - all Oracle users 
PROMPT       Query 2c - List Contents Of Module_tab - Installed Components - Review against various caches
PROMPT       Query 2d - Obsolete IFS UserIds
PROMPT       Query 2e - Objects deployed in SYS or SYSTEM schema but are also in the IFS Apps related schemas
PROMPT       Query 2f - Look for remnants of Oracle 8 Enterprise Manager objects found owned by APPOWNER
PROMPT       Query 2g - Determine if foreign key constraints exist in IFS schema.  Look for IFSAPP tables without Primary Key
PROMPT       Query 2h - Show job queue setup data (Batch Queue Configuration)
PROMPT       Query 2i - Background job logs by Job State 
PROMPT       Query 2j - List IFS Events that call code
PROMPT       Query 2k - Database triggers by owner, status
PROMPT       Query 2l - Ping test for PLSQL Access Provider
PROMPT       Query 2m - IFS Apps Licensing details
PROMPT     
PROMPT       Set 3 Data Volume Queries
PROMPT     
PROMPT       Query 3a - Data storage used for Materialized View Logs
PROMPT       Query 3b - Object count for MTK objects
PROMPT       Query 3c - Use of History Logging.
PROMPT       Query 3d - Show the sizes of the tables and the LOB segments used in application messaging.
PROMPT       Query 3e - Show the size and configuration of server_log_tab related objects
PROMPT       Query 3f - Show the sites defined
PROMPT     
PROMPT       Set 4 - Reports and Printing
PROMPT     
PROMPT       Query 4a - List number of reports, 'lifespan', in REPORT_ARCHIVE_TAB by report.
PROMPT       Query 4b - List number of reports, oldest of each report, in PDF_ARCHIVE_TAB by report.
PROMPT       Query 4c - Print Manager query
PROMPT       Query 4d - Reports in DB past expiration date
PROMPT       Query 4e - Check for orphaned print job contents
PROMPT       Query 4f - Check for issue with Financial Report Writer data cleanup
PROMPT       Query 4g - Show size of the reports data tables
PROMPT       Query 4h - Printing setup 
PROMPT     
PROMPT       Set 5 Data Inconsistencies
PROMPT     
PROMPT       Query 5a - Check for orphaned shop order cost records.
PROMPT       Query 5b - Check for orphaned records related to shop orders.
PROMPT       Query 5c - Check for shop orders for configured parts with zero costs
PROMPT       Query 5d - Check for DOP order close inconsistencies.
PROMPT       Query 5e -;
PROMPT       Query 5f -; 
PROMPT       Query 5g - Foundation related inconsistencies
PROMPT       Query 5h - Check for potential issues with transfer of maintenance transactions 
PROMPT       Query 5i -;
PROMPT       Query 5j -; 
PROMPT       Query 5k - PURCH related inconsistencies
PROMPT       Query 5l - INVOIC related inconsistencies
PROMPT       Query 5m - DOCMAN related inconsistencies
PROMPT       Query 5n - PAYLED related inconsistencies
PROMPT       Query 5o - INVENT related inconsistencies
PROMPT       Query 5p - MPCCOM/INVENT related inconsistencies - set variable query5p_extended=Y to run certain of these
PROMPT       Query 5q - ORDER related inconsistencies
PROMPT       Query 5r - SHPORD related inconsistencies
PROMPT       Query 5s - COST related inconsistencies
PROMPT       Query 5t - PROJ related inconsistencies
PROMPT     
PROMPT       Set 6 Data Volumes
PROMPT      
PROMPT       Query 6a - Determine number of rows in General Ledger related tables
PROMPT       Query 6b - Determine number of Projects and Activity Dates
PROMPT       Query 6c - Document Management usage
PROMPT       Query 6d - Determine number of Shop Orders and their state
PROMPT       Query 6e - Determine number of Customer Orders and their state
PROMPT       Query 6f - Determine number of Purchase Orders and their state
PROMPT       Query 6g - Determine number of Equipment Objects, Work Orders and their state
PROMPT       Query 6h - Determine number of inventory parts and their status
PROMPT       Query 6i - Business Analytics/Intelligence related
PROMPT     
PROMPT       Set 7 IFS Apps Configuration 
PROMPT     
PROMPT       Query 7a - List F1 Configuration Parameters
PROMPT     
PROMPT       Set 8 Data cleanup required for upgrade
PROMPT     
PROMPT       Query 8a - Determine use of DISCRETE UOMs
PROMPT       Query 8b - Check for transfer of inventory transactions to MPCCOM_ACCOUNTING_TAB
PROMPT       Query 8c - Check for inventory statistics update job execution status.
PROMPT       Query 8d - Check Language_sys_tab for rows to be dropped during Apps 8 upgrade
PROMPT  
PROMPT       ============================================================
PROMPT     

--  Query 1e - Get database character set information - set variable query1e_extended=Y to run extended diagnostics
var query1e_extended varchar2(1);
exec :query1e_extended := 'N';
--exec :query1e_extended := 'Y';
--
--  Query 1m - Show tables/indexes not analyzed for statistics 
var query1m_extended varchar2(1);
exec :query1m_extended := 'N';
--exec :query1m_extended := 'Y';
--
--  Query 1n - Show top 100 tables with empty space (estimated) - can extend to give resize table names
var query1n_extended    varchar2(1);
--var upgrade_in_progress varchar2(1);
exec :query1n_extended := :upgrade_in_progress;
--exec :query1n_extended := 'N';
--exec :query1n_extended := 'Y';
--
--  Query 5p - MPCCOM/INVENT related inconsistencies - set variable query5p_extended=Y to run certain of these
var query5p_extended varchar2(1);
exec :query5p_extended := 'N';
--exec :query5p_extended := 'Y';
--
PROMPT       ============================================================
PROMPT       Get SQL*Plus version being used
PROMPT       ============================================================
PROMPT       
define _sqlplus_release;
PROMPT       
PROMPT       
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       
PROMPT       Query 1a
PROMPT
PROMPT       Get Company Name from IFS DB
PROMPT       ============================================================
PROMPT
set echo off;
set feedback on;
column company          format a19;
column name             format a57;
column default_language format a10 heading 'Def|Lang';
column country          format a10;
column from_template_id format a23 heading 'From|Template|ID';
column from_company     format a20 heading 'From Company';
--
select company, name, country, default_language,
       from_template_id,from_company 
  from &&ifsappowner..company_tab
 order by company;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1b
PROMPT       ============================================================
PROMPT
--
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column isdefault    format a10;
column banner       format a80;
column name         format a45;
column product      format a40;
column status       format a20;
column value        format a80;
column version      format a15;
column comp_id      format a10;
column comp_name    format a35;
column namespace    format a20;
column control      format a10;
column schema       format a10;
column date_time    format a19;
--
PROMPT
set echo on;
set feedback off;
select * from v$version;


select a.*,
 '_______________________________________________________________________________________________________________________________________________' 
   from dba_registry a;



select * from sys.registry$history;



select * from dba_registry_sqlpatch;



select name, isdefault, value from v$parameter where name = 'compatible';



select * from product_component_version;


-- What version of Oracle Application Express is installed

select version from dba_registry where comp_id='APEX';



select * from v$database;



select * from v$instance;



select to_char (startup_time, 'mm-dd-yyyy  hh24:mi:ss') DB_started_date_time  from v$instance;

 
 
select dbms_utility.port_string from dual;


set feedback on;
--  v$parameter values not set to default values
 
select name, isdefault, value from v$parameter  where isdefault = 'FALSE' order by 1;



--  all v$parameter values 
 
select name, isdefault, value from v$parameter order by 1;



--  v$parameter values not set to default values, and are deprecated in this version of Oracle
 
--  Fails in Oracle 9
 
select name, isdefault, isdeprecated, value from v$parameter 
 where isdefault = 'FALSE'
   and isdeprecated = 'TRUE'
 order by 1;
--

--  v$parameter values deprecated in this version
--
--  Fails in Oracle 9
--
select name, isdefault, isdeprecated, value from v$parameter 
 where isdeprecated = 'TRUE' 
 order by name;
 
 
 
--  List "Shared Server" related V$PARAMETER settings
-- 
select name, isdefault, value from v$parameter 
 where name in 
 ('shared_servers', 'max_shared_servers', 'shared_server_sessions', 'dispatchers',
 'max_dispatchers', 'circuits')
 order by 1;

set feedback off;
column value format a15;

--  The Oracle database on a ipv6 server resolves the local name to ipv6 format:
 
select utl_inaddr.get_host_address from dual;
set echo off;
set serveroutput on size 1000000; 
PROMPT
PROMPT
PROMPT       ============================================================
PROMPT       SHOW CERTAIN PERFORMANCE RELATED PARAMETERS ORACLE 11/12
PROMPT         http://docs.oracle.com/cd/E11882_01/server.112/e25789/cncptdba.htm
PROMPT
PROMPT
PROMPT       ***>>INSTANCE
PROMPT 
PROMPT       NOTE:  IFS recommends NOT using Oracle Automatic Memory Management (AMM)
PROMPT 
PROMPT       Automatic Memory Management (AMM) for DB INSTANCE is
PROMPT       enabled when MEMORY_TARGET NOT = 0, and MEMORY_MAX_TARGET can be set.
PROMPT       These govern the total maximum RAM for both the PGA and SGA regions.
PROMPT
PROMPT       If Automatic Memory Management (AMM) for DB INSTANCE is
PROMPT       enabled the SGA and PGA cannot be tuned manually.
PROMPT
select name, isdefault, value from v$parameter 
 where name in ('memory_max_target','memory_target')
 order by 1;
-- 
declare
  c number;
begin
  select value into c from v$parameter where name = 'memory_target';

  if c = 0 then
     dbms_output.put_line(chr(10));
	 dbms_output.put_line('AMM is not enabled');
	
  else
     dbms_output.put_line(chr(10));
	 dbms_output.put_line('AMM is enabled');

  end if;
end;
/
PROMPT       ------------------------------------------------------------------------;
PROMPT
PROMPT       ***>>SGA
PROMPT 
PROMPT       When INSTANCE is NOT running Automatic Memory Management
PROMPT       the SGA can be running Automatic Memory Management or not.
PROMPT
PROMPT       If SGA_TARGET NOT = 0, Automatic Memory Management (AMM) for SGA is
PROMPT       enabled and SGA_MAX_SIZE can be set.
PROMPT
PROMPT       If SGA_TARGET = 0, SGA_MAX_SIZE will be calculated/set by Oracle.
PROMPT
PROMPT 
select name, isdefault, value from v$parameter 
 where name in ('sga_max_size', 'sga_target')
 order by 1;
PROMPT 
PROMPT       If SGA is NOT running Automatic Memory Management
PROMPT       You Can/Should Set SGA related parameters
PROMPT                Buffer cache size (DB_CACHE_SIZE)
PROMPT                Java pool size    (JAVA_POOL_SIZE)
PROMPT                Large pool size   (LARGE_POOL_SIZE)
PROMPT                Shared pool size  (SHARED_POOL_SIZE)
PROMPT                Streams pool size (STREAMS_POOL_SIZE)
PROMPT
select name, isdefault, value from v$parameter 
 where name in ('db_cache_size','java_pool_size','large_pool_size', 'shared_pool_size', 'streams_pool_size')
 order by 1;
PROMPT       ------------------------------------------------------------------------;
PROMPT
PROMPT       ***>>PGA
PROMPT 
PROMPT       When INSTANCE is NOT running Automatic Memory Management
PROMPT       the PGA can be running Automatic Memory Management or not.
PROMPT
PROMPT       Automatic Memory Management (AMM) for PGA is
PROMPT       enabled when PGA_AGGREGATE_TARGET IS NOT = 0
PROMPT
PROMPT 
select name, isdefault, value from v$parameter 
 where name in ('pga_aggregate_target')
 order by 1;
PROMPT 
PROMPT       If PGA is NOT running Automatic Memory Management
PROMPT       You Can/Should Set PGA related parameters
PROMPT
PROMPT                BITMAP_MERGE_AREA_SIZE
PROMPT                HASH_AREA_SIZE
PROMPT                SORT_AREA_SIZE
PROMPT                SORT_AREA_RETAINED_SIZE
PROMPT                WORKAREA_SIZE_POLICY
PROMPT
select name, isdefault, value from v$parameter 
 where name in 
 ('bitmap_merge_area_size', 'hash_area_size', 'sort_area_size', 'sort_area_retained_size', 'workarea_size_policy')
 order by 1;
PROMPT 
PROMPT
PROMPT       ------------------------------------------------------------------------;
PROMPT
select name, isdefault, value from v$parameter 
 where name in 
 ('bitmap_merge_area_size',
 'db_cache_size',
 'hash_area_size',
 'java_pool_size',
 'large_pool_size',
 'memory_max_target',
 'memory_target',
 'open_cursors',
 'optimizer_index_cost_adj',
 'pga_aggregate_target',
 'sga_max_size',
 'sga_target',
 'shared_pool_size',
 'streams_pool_size',
 'sort_area_size',
 'workarea_size_policy')
 order by 1;
PROMPT
PROMPT
PROMPT       ------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT       Current Buffer Cache Hit Ratio 
PROMPT
SELECT trunc((P1.value + P2.value - P3.value) / 
      (P1.value + P2.value)*100, 2)  Buffer_Cache_Hit_Ratio
   from v$sysstat p1, 
        v$sysstat p2, 
        v$sysstat p3
where p1.name = 'db block gets'
  and p2.name = 'consistent gets'
  and p3.name = 'physical reads';
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT       Times for scattered disk reads vs. sequential disk reads
PROMPT
column c1 heading 'Average Waits|Scattered Read|(Full Table Scans)|In Hundredths|of Seconds' format 9999.999;
column c2 heading 'Average Waits|Sequential Read|(Index Reads)|In Hundredths|of Seconds'     format 9999.999;
column c3 heading 'Percent of| I/O Waits|Scattered Reads'        format 999.99;
column c4 heading 'Percent of| I/O Waits|Sequential Reads'       format 999.99;
column c5 heading 'Starting Value|for optimizer|index cost adj'  format 999;
--
select
   a.average_wait                                  c1,
   b.average_wait                                  c2,
   a.total_waits /(a.total_waits + b.total_waits) * 100   c3,
   b.total_waits /(a.total_waits + b.total_waits) * 100   c4,
   (b.average_wait / a.average_wait)*100           c5
from
  v$system_event  a, v$system_event  b
where a.event = 'db file scattered read'
  and b.event = 'db file sequential read';
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT      
PROMPT       Show sga size
show sga;
--
column Value_In_MB format 999,999.999;
--
select name, value/1024/1024 Value_in_MB from v$sga;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT     
PROMPT       Show v$option values 
PROMPT

clear breaks columns computes;
 
column parameter format a40;
column value format a60;

set echo on;
select parameter, value from v$option order by 1;
set echo off;



column stat_name format a24;
column value format 999,999,999,999,999;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT  
PROMPT       Show v$osstat values 
PROMPT       Fails in Oracle 9
set echo on;
select * from v$osstat order by stat_name;
set echo off;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT 
PROMPT       Show database_properties values 
PROMPT 
column property_name  format a30;
column property_value format a40;
column description    format a55;
set echo on;
select * from database_properties
 order by 1;
set echo off;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT 
PROMPT       Please note that the information provided by this command is not trustworthy on 
PROMPT       multi-threaded, multi-core or virtual systems. It is the number of processors 
PROMPT       understood to be available by the database - not the number of processors 
PROMPT       which must be licensed.
set echo on;
select * from v$license;
set echo off;

clear breaks columns computes;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT 
PROMPT       Fails in Oracle 9
PROMPT 
PROMPT       Oracle Feature Usages Detected
--
-- Fails in Oracle 9
--
col name             format a65     heading "Feature";
col version          format a10     heading "Version";
col detected_usages  format 999,990 heading "Detected|usages";
col currently_used   format a06     heading "Curr.|used?";
col first_usage_date format a10     heading "First use";
col last_usage_date  format a10     heading "Last use";
col nop noprint;
break on nop skip 1 on name;
--
Select decode(detected_usages,0,2,1) nop,
       name, version, detected_usages, currently_used,
       to_char(first_usage_date,'MM/DD/YYYY') first_usage_date, 
       to_char(last_usage_date,'MM/DD/YYYY') last_usage_date
  from dba_feature_usage_statistics
 order by nop, 1, 2;
--
--
--
clear breaks columns computes;
--
break   on report;
compute sum of "Space Used (GB)"  on report;
compute sum of space_usage_kbytes on report;
--
column  name             format a40;
column  isdefault        format a10;
column  value            format a10;
--
column  occupant_name    format a40;
column  schema_name      format a25;
column  move_procedure   format a40;

column "space used (gb)"  format 999.99 HEADING "SPACE|USED|GB"
column space_usage_kbytes format 999,999,999;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
Prompt       Oracle Stats History Retention Period
Prompt       Fails in Oracle 9
Prompt  
select dbms_stats.get_stats_history_retention from dual;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT 
Prompt       What is stored in sysaux tablespace?
Prompt       Fails in Oracle 9
Prompt 
select occupant_name,
       space_usage_kbytes/1024/1024 "Space Used (GB)",
       schema_name,
       move_procedure
  from v$sysaux_occupants 
 order by 1;
--
--
--
clear columns;
column space_usage_kbytes format 999,999,999;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT 
Prompt       What is stored in sysaux tablespace - DETAILED
Prompt       Fails in Oracle 9
--
SELECT a.*,
   '_______________________________________________________________________________________________________'
   from v$sysaux_occupants a order by 1;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT 
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1c
PROMPT
PROMPT       User Account info
PROMPT       Processes/sessions and number unlocked oracle accounts
PROMPT
PROMPT       PASSWORD_LIFE_TIME  Specify the number of days the same password can be used for authentication.
PROMPT       If you also set a value for PASSWORD_GRACE_TIME, the password expires if it is not changed within 
PROMPT       the grace period, and further connections are rejected. If you do not set a value for 
PROMPT       PASSWORD_GRACE_TIME, its default of UNLIMITED will cause the database to issue a warning 
PROMPT       but let the user continue to connect indefinitely.
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
set echo off;
set verify off;
clear breaks columns computes;
--
column resource_name       format a15   heading "Parameters";
column current_utilization format 99999 heading "Current|Value";
column max_utilization     format 99999 heading "Max|Value|Reached";
column initial_allocation  format a10   heading "SPFILE|Value" justify right;
PROMPT
PROMPT Current and Max values for Processes and Sessions
PROMPT
select upper(resource_name) as resource_name,
       current_utilization,max_utilization,initial_allocation
  from v$resource_limit 
 where resource_name in ('processes', 'sessions');
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
--
--
clear breaks columns computes;
--
break on report;
column count format 999,999;
compute sum of count on report;
column account_status HEADING "Oracle Account Status"
--
--
PROMPT
PROMPT Total number of Oracle accounts
PROMPT
select distinct account_status,
       count (*) count 
  from dba_users
 group by account_status
 order by account_status;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT IFS Apps defined users and account status
--
--
column active format a15 heading "IFS|Account|Active?"
--
select distinct active, count(*) count
  from &&ifsappowner..fnd_user_tab 
 group by active
 order by active;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT IFS Apps defined Oracle users account status - IFS 2003
--
column active format a15 heading "IFS|Oracle User|Active?"
--
select distinct active, count(*) count 
  from &&ifsappowner..fnd_user_tab 
 where oracle_user is not null 
 group by active
 order by active;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT IFS Apps defined Web users account status - IFS 2003
--
column active format a15 heading "IFS|Web User|Active?"
--
select distinct active, count(*) count 
  from &&ifsappowner..fnd_user_tab 
 where web_user is not null 
 group by active
 order by active;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT       IFS Users Sharing a given OS Account
PROMPT
--
--
column a.username format a20;
column a.osuser   format a20;
--
select a.username, a.osuser
  from v$session a, 
       (select distinct a.username
          from v$session a, v$session b
        where a.username = b.username
           and a.osuser != b.osuser
           and a.username not in ('SYS', 'IFSSYS') 
        ) b
  where a.username = b.username
  order by a.username, a.osuser;
--     
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
column active format a15 heading "IFS|Account|Active?"
--PROMPT Accounts with IFS in the name and other IFS related accounts, and account lock status
PROMPT
PROMPT Accounts for Apps 9:
PROMPT
PROMPT   IFSADMIN
PROMPT   IFSANONYMOUS
PROMPT   IFSAPP      (or other name for App Owner)
PROMPT   IFSCONNECT
PROMPT   IFSINFO     (or other name for account to manage IALs)
PROMPT   IFSMOBILITY ???
PROMPT   IFSPLSQLAP
PROMPT   IFSSYS
PROMPT   IFSWEBCONFIG
PROMPT
--
clear breaks columns computes;
--
column account_status       format A25 heading "Account|Status";
column default_tablespace   format A20 heading "Default|Tablespace";
column segment_name         format A35;
column temporary_tablespace format A20 heading "Temporary|Tablespace";
column lock_date            format A15 heading "Lock|Date";
column expiry_date          format A15 heading "Expiry|Date";
column username             format A24;
column owner                format A24;
column User_Type            format A25;
--
select username, default_tablespace, temporary_tablespace,
       account_status, lock_date, expiry_date
  from dba_users
 where username like 'FND%'
    or username like '%IFS%'
    or username like '%BYTE'
    or username like '%CHAR'
    or username like 'SALESAND%'
    or username like 'SYS%'
    or username = :IFSAPPOWNER_UC
    or username = :IFSINFO_UC
    or username in ('AGILE','FEDEX','IFSFAX','CLIPPERSHIP','UPSWS') -- IFSNA Freight Interface
    or username = 'IFSFAX' -- IFSNA Fax Interface
	or username = 'RADLEY'
 order by username;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Users should not use special Oracle tablespaces for objects
PROMPT
select distinct owner, tablespace_name, segment_name, segment_type
  from dba_segments 
 where (tablespace_name like  'SYS%'
     or tablespace_name like  'UNDO%')
   and (owner not in ('APEX_030200','APEX_040000','APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','DMSYS','DSSYS',
                      'DVSYS','EXFSYS','FLOWS_010600','FLOWS_030000','FLOWS_FILES','GSMADMIN_INTERNAL','LBACSYS',
                      'MDSYS','ORDPLUGINS','OLAPSYS','ORACLEBIPUB','ORDDATA','ORDSYS','OUTLN',
                      'PERFSTAT','SYS','SYSMAN','SYSTEM','TSMSYS','WKPROXY','WKSYS','WMSYS','XDB'))
 group by owner, tablespace_name, segment_name, segment_type
 order by owner, tablespace_name, segment_name;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Users whose Temporary tablespace is not defined as a TEMPORARY tablespace
PROMPT
select distinct username, temporary_tablespace
      from dba_users du, dba_tablespaces dt
     where du.temporary_tablespace = dt.tablespace_name
       AND dt.contents ^= 'TEMPORARY'
     group by username,temporary_tablespace
     order by username;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Users should not have a single quote in their username, imports can fail 
PROMPT on some versions.   Use datapump instead
PROMPT
select username  from dba_users where username like '%''%';
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT IFS System user profile details
PROMPT
column grantee       format a30;
column limit         format a30;
column profile       format a30;
column resource_name format a30;
--
select distinct dp.profile, dp.resource_name, dp.limit
  from dba_profiles dp,  
        (select username, profile
           from dba_users
          where username in ('IFSACCESS', 'IFSADMIN', 'IFSCONNECT', 'IFSMOBILITY', 'IFSPLSQLAP', 'IFSPRINT', 'IFSSYS', 'IFSWEBCONFIG')
         ) up
where dp.profile = up.profile
order by 1, 2;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Oracle Profile details
PROMPT
select profile, resource_name, limit 
  from dba_profiles
 order by 1, 2;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Oracle Role Usage counts
PROMPT
select * from 
    (select distinct grantee, count (*) 
       from dba_role_privs 
      group by grantee 
      order by count (*) desc, grantee) 
 where rownum <26;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Predefined Administrative User Accounts
PROMPT
SELECT 'Predefined Administrative User Accounts' PREDEFINED_ACCOUNTS, count(*)
  FROM dba_users
 WHERE username in 
      ('ANONYMOUS', 'CTXSYS',   'DBSNMP', 'EXFSYS', 'LBACSYS',
       'MDSYS',     'MGMT_VIEW','OLAPSYS','OWBSYS', 'ORDPLUGINS', 
       'ORDSYS',    'OUTLN',    'SI_INFORMTN_SCHEMA','SYS', 
       'SYSMAN',    'SYSTEM',   'TSMSYS', 'WK_TEST', 'WKSYS',
       'WKPROXY',   'WMSYS',    'XDB')
UNION
SELECT 'Default Sample Schema User Accounts', count(*)
  FROM dba_users
 WHERE username in ('BI','HR','OE','PM','IX','SH')
UNION
SELECT 'Predefined Non-Administrative User Accounts' PREDEFINED_ACCOUNTS, count(*)
  FROM dba_users
 WHERE username in 
      ('APEX_PUBLIC_USER','DIP',   'FLOWS_010600','FLOWS_030000','FLOWS_FILES','MDDATA',
       'ORACLE_OCM',      'PUBLIC','SPATIAL_CSW_ADMIN_USER',
       'SPATIAL_WFS_ADMIN_USR',    'XS$NULL');
--
prompt
prompt Predefined Administrative User Accounts
prompt
--
SELECT 'Administrative User     ' User_Type, username, account_status, lock_date, expiry_date
  FROM dba_users
 WHERE username in 
      ('ANONYMOUS', 'CTXSYS',   'DBSNMP', 'EXFSYS', 'LBACSYS',
       'MDSYS',     'MGMT_VIEW','OLAPSYS','OWBSYS', 'ORDPLUGINS', 
       'ORDSYS',    'OUTLN',    'SI_INFORMTN_SCHEMA','SYS', 
       'SYSMAN',    'SYSTEM',   'TSMSYS', 'WK_TEST', 'WKSYS',
       'WKPROXY',   'WMSYS',    'XDB')
UNION
SELECT 'Sample Schema User      ', username, account_status, lock_date, expiry_date
  FROM dba_users
 WHERE username in ('BI','HR','OE','PM','IX','SH')
union
SELECT 'Non-Administrative User: ' User_Type, username, account_status, lock_date, expiry_date
  FROM dba_users
 WHERE username in 
      ('APEX_PUBLIC_USER','DIP',   'FLOWS_010600','FLOWS_030000','FLOWS_FILES','MDDATA',
       'ORACLE_OCM',      'PUBLIC','SPATIAL_CSW_ADMIN_USER',
       'SPATIAL_WFS_ADMIN_USR',    'XS$NULL');
--
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1e
PROMPT
PROMPT       Get database character set information
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
set echo off;
--
clear breaks columns computes;
--
column db_parameter   format a30;
column db_value       format a34; 
column owner          format a18; 
column instance_value format a30;
column session_value  format a30;
--
select d.parameter db_parameter,
       d.value     db_value,
       i.value     instance_value,
       s.value     session_value
  from nls_database_parameters d, 
       nls_instance_parameters i,
       nls_session_parameters s
 where d.parameter = i.parameter (+)
   and d.parameter = s.parameter (+)
 order by 1;
-- 
--
--
clear breaks columns computes;
column table_name    format a35;
column column_name   format a30;
column owner         format a18;
column data_length   format 99999 heading 'Data|Length' JUSTIFY RIGHT;
column char_length   format 99999 heading 'Char|Length' JUSTIFY RIGHT;
column char_used     format a4 heading 'Char|Used';
column data_type     format a15;
--
--
Prompt  
Prompt  FND_SESSION_TAB
Prompt   
--
select owner, table_name, column_name, data_length, 
       char_length, char_used, data_type
  from dba_tab_columns
 where table_name = 'FND_SESSION_TAB'
 order by owner;
-- 
--
Prompt 
Prompt  FND_SESSION
Prompt 
--
select owner, table_name, column_name, data_length, 
       char_length, char_used, data_type
  from dba_tab_columns
 where table_name = 'FND_SESSION'
 order by owner;
-- 
--
--
Prompt
Prompt  XLR_REPORT_UPG_UTILITY_TAB is new for Apps 8 
Prompt 
--
select owner, table_name, column_name, data_length, 
       char_length, char_used, data_type
  from dba_tab_columns
 where table_name = 'XLR_REPORT_UPG_UTILITY_TAB'
 order by owner;
--
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt  INVENTORY_PART_TAB has been in the product since the dawn of time
Prompt  and is best indicator of potential data length issues that may
Prompt  have occurred during prior upgrades.
Prompt
--
select owner, table_name, column_name, data_length, 
       char_length, char_used, data_type
  from dba_tab_columns
 where table_name = 'INVENTORY_PART_TAB' 
 order by owner;
--
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt  View definition for INVENTORY_PART
Prompt
--
select owner, table_name, column_name, data_length, 
       char_length, char_used, data_type
  from dba_tab_columns
 where table_name = 'INVENTORY_PART'
 order by owner;
--
--
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt   If following query returns rows, this needs to be investigated
Prompt   There is a potential issue with character set definition
Prompt   
Prompt   The database is running as CHAR but table columns are not defined as CHAR
--
column owner format a18;
column Instance_NLS_Length_semantics format a7 heading 'INST|NLS|LEN|SEM';
--
select * from 
(
select atc.owner, 
       atc.table_name, 
       atc.column_name, 
       atc.data_type,
       atc.char_used,
       atc.data_length,
       atc.char_length,
       nip.value Instance_NLS_Length_semantics
from dba_tab_cols atc,
     dba_tables at,
     nls_instance_parameters nip
where atc.owner      in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
  and at.owner       = atc.owner
  and atc.table_name = at.table_name 
  and atc.data_type  = 'VARCHAR2'              -- Test VARCHAR2 only
  and nip.value      = 'CHAR'                  -- If DB instance running CHAR,
  and nip.parameter  = 'NLS_LENGTH_SEMANTICS'   
  and (
       (     data_length  = char_length
         and data_length ^= 4000)              -- then lengths should be not be the same unless data length = 4000 
        or (  data_length ^= char_length * 4   -- and data_length should be 4x char_length unless data length = 4000
          and data_length ^= 4000)
       or char_used = 'B'                      -- If DB running CHAR, columns should be defined as CHAR
       )    
order by 1,2,3
) 
where rownum < 251;
--where rownum < 100000;
--
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt  If following query returns rows, this needs to be investigated
Prompt  There is a potential issue with character set definition
Prompt 
Prompt  The database is running as BYTE but table columns are not defined as BYTE
Prompt 
--
select * from 
(
select atc.owner, 
       atc.table_name, 
       atc.column_name, 
       atc.data_type,
       atc.char_used,
       atc.data_length,
       atc.char_length,
       nip.value Instance_NLS_Length_semantics
from dba_tab_cols atc,
     dba_tables at,
     nls_instance_parameters nip
where atc.owner      in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
  and at.owner       = atc.owner
  and atc.table_name = at.table_name 
  and atc.data_type  = 'VARCHAR2'                 -- test VARCHAR2 only
  and nip.value      = 'BYTE'                     -- if DB instance running BYTE
  and nip.parameter  = 'NLS_LENGTH_SEMANTICS'   
  and data_length   ^= char_length                -- then lengths should be the same, show those that are not
order by 1,2,3
)
where rownum < 251;
--where rownum < 100000;
--
--
--
clear breaks columns computes;
--
break on report;
compute sum of count on report;
--
column owner         format a25;
column table_name    format a35;
column column_name   format a35;
column data_length   format 99999 heading 'Data|Length' JUSTIFY RIGHT;
column char_length   format 99999 heading 'Char|Length' JUSTIFY RIGHT;
column char_used     format a4 heading 'Char|Used';
column data_type     format a15;
column count         format 999,999;
--
--  Remember dba_tab_columns includes views so we must specifically exclude them
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt  Summary of data type / char usage across all users
Prompt  
--
select distinct dtc.owner, char_used, data_type, count(*) count
  from dba_tab_columns dtc
 where data_type like '%CHAR%'
   and table_name not in (select view_name from dba_views dv where dv.owner = dtc.owner)
  group by owner, char_used, data_type
  order by owner, char_used, data_type;
--
--
--
--  For much more detailed reports on database character set issues use following queries.
--  Set variable query1e_extended at top of script
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt  Char_used is BYTE, check data_length vs. char_length
Prompt  
select dtc.owner, table_name, column_name, char_used, data_type, data_length, char_length
  from dba_tab_columns dtc
 where data_type like '%CHAR%'
   and char_used = 'B'
   and table_name not in (select view_name from dba_views dv where dv.owner = dtc.owner)
   and owner in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
   and :query1e_extended = 'Y'
 order by owner, table_name, column_name, char_used, data_type;
--
--
--  Set variable query1e_extended at top of script
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt  Char_used is CHAR, check data_length vs. char_length
Prompt  
--
select dtc.owner, table_name, column_name, char_used, data_type, data_length, char_length
  from dba_tab_columns dtc
 where data_type like '%CHAR%'
   and char_used = 'C'
   and table_name not in (select view_name from dba_views dv where dv.owner = dtc.owner)
   and owner in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
   and :query1e_extended = 'Y'
 order by dtc.owner, table_name, column_name, char_used, data_type;
--
--
--  Set variable query1e_extended at top of script
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt  This query should show combined results of above two queries, 
Prompt  to show column by column differences in a particular table.
Prompt  
--
break on char_used skip 1;
--
select dtc.owner, table_name, column_name, char_used, data_type, data_length, char_length
  from dba_tab_columns dtc
 where data_type like '%CHAR%'
   and table_name not in (select view_name from dba_views dv where dv.owner = dtc.owner)
   and owner in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
   and :query1e_extended = 'Y'
 order by dtc.owner, table_name, column_name, char_used;
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1f
PROMPT
PROMPT       List PL/SQL Code Optimization Level and nls_length_semantics value
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
break on owner skip 1 on report;
compute sum of count on report;
--
column object_type format a18;
column owner       format a25;
column param_name  format a22;
column param_value format a22 heading 'NLS_LENGTH_SEMANTICS|(Compiled as)';
column plsql_code_type format a25;
column plsql_debug format a12;
column nls_length_semantics format a10 heading 'NLS|LENGTH|SEMANTICS' just right;
column plsql_optimize_level format 999 heading 'PLSQL|OPTIMIZE|LEVEL';
column count format 999,999,999 justify right;
--
--
--  Works in Oracle 9, 10, 11
Prompt
Prompt Show NLS_LENGTH_SEMANTICS for compiled code
--
select distinct owner, object_type, count(*) count, param_value 
  from dba_stored_settings
 where param_name = 'nls_length_semantics'  --and owner in ('IFSAPP','IFSINFO') 
 group by owner, object_type, param_value
 order by owner, object_type, param_value;
--
--
--
break on owner skip 1 on report;
--  Fails in Oracle 9
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt Show Optimize level and Debug Status
--
select distinct owner, count(*) count,
       nls_length_semantics, plsql_optimize_level, plsql_debug, plsql_code_type
  from dba_plsql_object_settings
 group by owner, nls_length_semantics, plsql_optimize_level, plsql_debug, plsql_code_type
 order by owner, nls_length_semantics, plsql_optimize_level, plsql_debug, plsql_code_type;
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt Show objects compiled in different mode than database running in
PROMPT
--
column name format a35;
--
--  Fails in Oracle 9
--
select * from
(select owner, name, type, nls_length_semantics 
   from dba_plsql_object_settings 
  where owner in (:IFSAPPOWNER_UC, :IFSINFO_UC, 'IFS360')
    and nls_length_semantics not in 
        (select value from v$parameter where name = 'nls_length_semantics')
  order by owner,name)
  where rownum < 501;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1g
PROMPT
PROMPT       Show tablespaces total space used, allocated, free, percent
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column  dummy noprint;
column  pct_used format 999.9            heading "%|Used";
column  name     format a30              heading "Tablespace Name";
column  mbytes   format 9,999,999,999.9  heading "MBytes|Allocated";
column  num_datafiles format 999,999     heading "Num|Data|Files";
column  num_segs format 999,999          heading "Num|Segs" newline;
column  mused    format 9,999,999,999.9  heading "MBytes|Used";
column  mfree    format 9,999,999,999.9  heading "MBytes|Free";
column  mlargest format 9,999,999,999.9  heading "Largest|Contiguous|Freespace|(Mbytes)";
column  free_chunks format 999,999       heading "Free|Chunks";
column  fragmentation_index              heading "Frag|Factor";
column  tablespace_name format a35;
--
break   on report;
compute sum of mbytes on report;
compute sum of mused  on report;
compute sum of mfree  on report;
compute sum of num_segs  on report;
compute sum of num_datafiles  on report;
--
--
select nvl(b.tablespace_name,nvl(a.tablespace_name,'UNKNOWN')) name,
       nvl(c.COUNT,0) Num_segs,
       count_tn num_datafiles,
       kbytes_alloc/1024 mbytes,
       (kbytes_alloc-nvl(kbytes_free,0))/1024 mused,
       nvl(kbytes_free,0)/1024 mfree,
       ((kbytes_alloc-nvl(kbytes_free,0))/
                          kbytes_alloc)*100 pct_used,
       nvl(klargest,0)/1024 mlargest,
       free_chunks,
       fragmentation_index,
       '___________________________________________________________________________________________________________________'
from ( select sum(bytes)/1024 kbytes_free,
              max(bytes)/1024 klargest,
              tablespace_name,
              nvl(round(sqrt(max(blocks)/sum(blocks))*(100/sqrt(sqrt(count(blocks)) )),0),0) fragmentation_index,
       count(*) free_chunks
       from  sys.dba_free_space
       group by tablespace_name ) a,
     ( select sum(bytes)/1024 kbytes_alloc, count (*) count_tn,
              tablespace_name
       from sys.dba_data_files
       group by tablespace_name )b,
 (select count(ds.segment_name) Count,
	         tablespace_name
       from dba_segments ds
      group by ds.tablespace_name) c
where a.tablespace_name  = b.tablespace_name
  and a.tablespace_name  = c.tablespace_name (+)
order by 1;
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
prompt Fragmentation Factor is an indicator of relative degree of fragmentation free space in a tablespace.
prompt Fragmentation Factor of 100 means very low free space fragmentation
prompt Fragmentation Factor of   1 means very high free space fragmentation
prompt
--
--
select tablespace_name,
       count(*) free_chunks,
       decode(
          round((max(bytes) / 1024 / 1024),1),
          null,0,
          round((max(bytes) / 1024 / 1024),1)) mlargest,
       nvl(round(sqrt(max(blocks)/sum(blocks))*(100/sqrt(sqrt(count(blocks)) )),0),0) fragmentation_index
  from sys.dba_free_space 
 group by tablespace_name
 order by 1;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1h
PROMPT
PROMPT       Show table spaces and data files
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
--
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column  tablespace_name          format a20;
column  file_name                format a68;
column  allocation_type          format a10       heading "ALLOCATION|TYPE";
column  block_size               format 9999999   heading "BLOCK|SIZE";
column  extent_management        format a10       heading "EXTENT|MGMT";
column  force_logging            format a7        heading "FORCE|LOGGING";
column  initial_extent           format 999999999 heading "INITIAL|EXTENT";
column  next_extent              format 999999999 heading "NEXT|EXTENT";
column  segment_space_management format a10       heading "SEGMENT|SPACE|MANAGEMENT";
--
set echo on;
set feedback on;
select * from dba_tablespaces
 order by 1;
--
--
--  SHOW UNDO TABLESPACES
--
select tablespace_name, segment_space_management, extent_management, contents
  from dba_tablespaces 
 where contents = 'UNDO'
 order by 1;
--
--
--  SHOW TEMPORARY TABLESPACES
--
select tablespace_name, segment_space_management, extent_management, contents
  from dba_tablespaces 
 where contents = 'TEMPORARY'
 order by 1;
--
--
--  SHOW SEGMENT_SPACE_MANAGEMENT NOT AUTO
--
select tablespace_name, segment_space_management, extent_management, contents
  from dba_tablespaces 
 where segment_space_management ^= 'AUTO'
 order by 1;
--
--
--  SHOW SEGMENT_SPACE_MANAGEMENT NOT LOCAL
--
select tablespace_name, segment_space_management, extent_management, contents
  from dba_tablespaces 
 where extent_management ^= 'LOCAL'
 order by 1;
--
--
--  SHOW TABLESPACES NOT ONLINE
--
select * from dba_tablespaces
 where status ^= 'ONLINE'
 order by 1;
--
--
--
--  Fails in Oracle 9, 10.1
--
select * from dba_data_files
 where ((online_status ^= 'ONLINE' and online_status ^= 'SYSTEM')
    or  upper(file_name) like '%MISS%')
	and file_id > 1
 order by file_id;
-- 
--
--
set echo off;
break   on report;
column  status format a15;
column  member format a15;
column  file_name format a70;
column  bytes  format 999,999,999,999,999.9  heading "Bytes|Allocated";
column  mbytes format 999,999,999,999,999.9  heading "MBytes|Allocated";
column  online_change# format 999,999,999,999,999;
column  checkpoint_change#  format 999,999,999,999,999,999;
compute sum of bytes on report;
compute sum of mbytes on report;
set echo on;
--
select a.file#,b.TS#,b.name Tablespace_name,a.*, bytes/1024/1024 mbytes,
          '___________________________________________________________________________________________________________________________________________'
     from v$datafile a,
     v$tablespace b
     where a.ts# = b.ts#
     order by a.file#;
-- 
--
--
column  tablespace_name format a30;
--
select b.name Tablespace_name, a.name File_name,  a.file#, bytes/1024/1024 mbytes
     from v$datafile a,
     v$tablespace b
     where a.ts# = b.ts#
     order by b.name, a.name;
--
--
set feedback off;
--
select distinct checkpoint_change# from v$datafile;


select * from v$tempfile;


select * from dba_temp_files;


select distinct status from v$archive_processes;


archive log list;


select destination from v$archive_dest where status = 'VALID';


column member format a80;
--
select log.group#, log.status, 
       log.bytes /1024/1024  Log_Size_MB,
       lf.member
  from v$log log, v$logfile lf
 where log.group# = lf.group#
 order by 1, 2, 4;

 
select name from v$controlfile;


set echo off;
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS as SYSDBA
PROMPT
PROMPT       Query 1i
PROMPT
PROMPT       Show space usage of tablespaces and segments by owner
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column owner           format a24 heading 'Segment Owner';
column Size_in_MB      format 9,999,999.9;
column Size_in_MB_LOBS format 9,999,999.9;
column Num_of_segments format 999,999 heading 'Number of|Segments';
column tablespace_name format a30;
--
break on tablespace_name skip 1 on report;
compute sum of Size_in_MB       on report;
compute sum of Size_in_MB_LOBS  on report;
compute sum of Num_of_segments  on report;
--
--
--
Prompt
Prompt Tablespace usage by all owners
Prompt
--
select distinct dt.tablespace_name, owner,
       sum(bytes)/1024/1024 Size_in_MB 
  from dba_segments ds,
       dba_tablespaces dt
 where ds.tablespace_name(+)=dt.tablespace_name
 group by dt.tablespace_name,owner
 order by dt.tablespace_name,owner;
--
--
--   BELOW TAKES A LONG TIME TO RUN ON MOST SYSTEMS
--Prompt
--Prompt  Tablespace/segment usage by all owners
--Prompt
----
--select distinct dt.tablespace_name, owner, segment_type,
       --count (ds.segment_name) Num_of_segments,
--       sum(bytes)/1024/1024 Size_in_MB 
  --from dba_segments ds,
       --dba_tablespaces dt
 --where ds.tablespace_name(+) = dt.tablespace_name
   --and dt.contents ^= 'TEMPORARY'
 --group by dt.tablespace_name, owner, segment_type
-- order by dt.tablespace_name, owner, segment_type;
----
--
--
Prompt
Prompt Space usage by owner, no LOBS
Prompt
--
select distinct owner,sum(bytes)/1024/1024 Size_in_MB 
  from dba_segments 
 where segment_type not like 'LOB%'
 group by owner
 order by owner;
--
--
--
Prompt
Prompt  Space usage by owner, only LOBS
Prompt
--
select distinct s.owner, sum(bytes)/1024/1024 Size_In_MB_LOBS
  from dba_lobs l,dba_segments s
 where l.segment_name = s.segment_name
 group by s.owner
 order by s.owner;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1j
PROMPT 
PROMPT       Show 200 largest objects (non-LOB) by database segments use by Appowner
PROMPT       Show 200 largest objects (non-LOB) by database segments use by other than Appowner
PROMPT       Show 100 largest LOB objects by database segments use by Appowner
PROMPT       Show 100 largest LOB objects by database segments use by other than Appowner
PROMPT
PROMPT       ============================================================
PROMPT
-- 
set timing on;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break   on report;
compute sum of Tot_Size_in_MB on report;
--
column Appowner        format a15 heading 'Appowner';
column column_name     format a30;
column lob_col         format a55;
column owner           format a24;
column segment_count   format 999,999,999 heading 'Segment|Count';
column segment_name    format a35;
column segment_type    format a13;
column table_name      format a35;
column tablespace_name format a30;
column Tot_Size_in_MB  format 9,999,999.9 heading 'Total Size|In MB';
--
Prompt 
Prompt 
Prompt  Show 200 largest Appowner objects by database segments size
Prompt  No LOBS
--
--
select  a.* from
(select distinct :IFSAPPOWNER_UC Appowner, segment_name, count(*) segment_count,
        sum(bytes)/1024/1024 Tot_Size_in_MB,
        tablespace_name
   from user_segments 
  where segment_type not like 'LOB%'
  group by :IFSAPPOWNER_UC,segment_name,tablespace_name
  order by Tot_Size_in_MB desc, segment_name ) a
  where rownum <= 200;
--
-- 
--
connect &&sys_connect;
show user;
--
Prompt 
Prompt 
Prompt  Show 200 largest objects by database segments use by other than Appowner that are > 2 MB
Prompt  No LOBS
Prompt 
select  a.* from
(select distinct owner, segment_name, count(*) segment_count,
        sum(bytes)/1024/1024 Tot_Size_in_MB,
        tablespace_name
   from dba_segments 
  where owner not in ('APEX_030200','APEX_040000','APEX_040200','APPQOSSYS','CTXSYS','DBSNMP','DMSYS','DSSYS','EXFSYS','FLOWS_010600','FLOWS_030000','FLOWS_FILES',
                      'GSMADMIN_INTERNAL','MDSYS','ORDPLUGINS','OLAPSYS','ORACLEBIPUB','ORDDATA','ORDSYS','OUTLN',
                      'PERFSTAT','SYS','SYSMAN','SYSTEM','TSMSYS','WKPROXY','WKSYS','WMSYS','XDB')
    and owner ^ = :IFSAPPOWNER_UC
    and segment_type not like 'LOB%'
  group by owner, segment_name, tablespace_name
  order by Tot_Size_in_MB desc ) a
  where rownum <= 200
    and Tot_Size_in_MB > 2;
show user;
--
--
--
Prompt 
Prompt 
Prompt  Show 100 largest LOB objects by database segments owned by Appowner
Prompt 
--
select   :IFSAPPOWNER_UC Appowner, table_name,segment_count,Tot_Size_in_MB,tablespace_name
from 
--
(select  distinct :IFSAPPOWNER_UC Appowner, a.table_name,segment_count,a.Tot_Size_in_MB,b.tablespace_name
from
--
(select distinct :IFSAPPOWNER_UC Appowner, l.table_name, sum(bytes)/1024/1024 Tot_Size_in_MB, count(*) segment_count
   from dba_lobs l, dba_segments s
  where l.segment_name = s.segment_name
    and l.owner        = s.owner
    and l.owner        = :IFSAPPOWNER_UC
  group by table_name order by table_name) a,
           dba_segments b
  where a.table_name = b.segment_name
--
order by a.Tot_Size_in_MB desc, table_name)
--
where rownum <= 100;
--
--
Prompt
Prompt
Prompt  Show 100 largest LOB objects by database segments use by other than Appowner that are > 2 MB
Prompt
--
--
select owner, table_name,segment_count, Tot_Size_in_MB, tablespace_name
from 
--
(select distinct a.owner, a.table_name, segment_count, a.Tot_Size_in_MB, b.tablespace_name
from
--
(select distinct s.owner,table_name, sum(bytes)/1024/1024 Tot_Size_in_MB, count(*) segment_count
   from dba_lobs l,dba_segments s
  where l.segment_name = s.segment_name
    and l.owner        = s.owner
  group by s.owner,table_name) a, 
--
dba_segments b
where a.table_name = b.segment_name 
  and a.owner not in ('APEX_030200','APEX_040000','APEX_040200','APPQOSSYS','CTXSYS','DBSNMP','DMSYS','DSSYS','EXFSYS','FLOWS_010600','FLOWS_030000','FLOWS_FILES',
                      'GSMADMIN_INTERNAL','MDSYS','ORDPLUGINS','OLAPSYS','ORACLEBIPUB','ORDDATA','ORDSYS','OUTLN',
                      'PERFSTAT','SYS','SYSMAN','SYSTEM','TSMSYS','WKPROXY','WKSYS','WMSYS','XDB')
  and a.owner ^ = :IFSAPPOWNER_UC
 order by a.Tot_Size_in_MB desc)
--
where rownum <= 100
  and Tot_Size_in_MB > 2;
--
--
--
Prompt
Prompt
Prompt  Show all objects > 100 MB, all owners, LOB or not
Prompt
--
select owner,
       segment_type,
       segment_name,
       round(bytes / 1024 / 1024) Tot_Size_in_MB,
       case
         when segment_type = 'LOBSEGMENT' then
          (select table_name || '.' || column_name
             from dba_lobs b
           where b.owner = a.owner
              and b.segment_name = a.segment_name)
         when segment_type = 'LOBINDEX' then
          (select table_name || '.' || column_name
             from dba_lobs b
            where b.owner = a.owner
              and b.index_name = a.segment_name)
       end lob_col
  from dba_segments a
where bytes >= 100 * 1024 * 1024 -- 100M 
  and segment_type ^= 'TYPE2 UNDO'
 order by bytes desc, segment_type, segment_name;
--
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS
PROMPT
PROMPT       Query 1l
PROMPT
PROMPT       Show extent usage - > 500 extents for a segment 
PROMPT          potential performance issue
PROMPT
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
set echo off;
--
clear breaks columns computes;
--
column Extent_Size_MB  format 999,999.9;
column Extent_Count    format 999,999,999;
column initial_extent  format 999,999,999,999;
column next_extent     format 999,999,999,999;
column num_rows        format 99,999,999,999;
column owner           format a20 heading 'Object Owner';
column segment_name    format a30;
column table_name      format a30;
column tablespace_name format a30;
--
break   on report;
compute sum of Extent_Size_MB on report;
compute sum of Extent_Count on report;
-- 
select a.* from 
(select distinct owner,segment_name,tablespace_name,count (*) Extent_Count,
sum(bytes)/1024/1024 Extent_Size_MB   
from dba_extents
--group by owner,segment_name
-- where segment_name = 'PDF_ARCHIVE_TAB'
group by owner,segment_name,tablespace_name
order by Extent_Count desc) a
where rownum < 10000
  and Extent_Count > 500;
--
-- 
-- 
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT       Run as SYS
PROMPT
PROMPT       Query 1m
PROMPT
PROMPT       Show status of tables/indexes statistics 
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
break on owner skip 1 on type skip 1;
column owner      format a15 heading 'Owner';
column stats      format a7 heading 'Stale|Stats?';
column type       format a7;
--
select distinct owner, type, stats, count(*) from 
(select owner,'INDEX' type, nvl(stale_stats,'NUL') stats, index_name object from dba_ind_statistics 
  where owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360' or owner = 'SYS' or owner = 'RADLEY'
union
select owner,'TABLE' type, nvl(stale_stats,'NUL') stats, table_name object from dba_tab_statistics 
 where owner  = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360' or owner = 'SYS' or owner = 'RADLEY')
group by owner, type, stats 
order by owner, type desc, stats desc;
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
clear breaks columns computes;
--
column OWNER      format a15 heading 'Owner';
column OBJ_TYPE   format a10 heading 'Object|Type';
column TABLE_NAME format a35;
column Last_Analyzed format date heading 'Date Last|Analyzed';
column target_date format date heading 'Target|Date';
column Sample_Pcent format 999;
column num_rows format 999,999,999;
Prompt
Prompt Set variable query1m_extended at top of script
Prompt to get all ifs objects last_analyzed_date
Prompt
--
select * from 
(select owner, 'TABLE' OBJ_TYPE, table_name, num_rows,sample_size/(num_rows+.01)*100 Sample_Pcent,
        (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY'))) Last_Analyzed,
        sysdate -90 target_date
   from dba_tables 
  where (owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360')
    and table_name not like 'BIN$%==$0'
    and (num_rows > 1000 or num_rows is null)
--    and (nvl(last_analyzed,sysdate-10026))  < sysdate -90
    and (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY')))  < sysdate -90
union 
select  owner,'INDEX' OBJ_TYPE,index_name, num_rows,sample_size/(num_rows+.01)*100 Sample_Pcent,
        (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY'))) Last_Analyzed,
        sysdate -90 target_date
  from dba_indexes 
 where (owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360')
   and index_name not like 'BIN$%==$0'
   and (num_rows > 1000 or num_rows is null)
    and (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY')))  < sysdate -90
)
  where :query1m_extended = 'Y'
  order by owner,obj_type desc,last_analyzed,num_rows desc,table_name;
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT
Prompt
Prompt Set variable query1m_extended at top of script
Prompt to get all ifs objects last_analyzed_date
Prompt
--  
select * from 
(select owner, 'TABLE' OBJ_TYPE, table_name, num_rows,sample_size/(num_rows+.01)*100 Sample_Pcent,
        (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY'))) Last_Analyzed
   from dba_tables 
  where (owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360')
    and table_name not like 'BIN$%==$0'
  --  and (num_rows > 1000 or num_rows is null)
union 
select  owner,'INDEX' OBJ_TYPE,index_name, num_rows,sample_size/(num_rows+.01)*100 Sample_Pcent,
        (nvl(last_analyzed,to_date('07-DEC-1941','DD-MON-YYYY'))) Last_Analyzed
  from dba_indexes 
 where (owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC or owner = 'IFS360')
   and index_name not like 'BIN$%==$0'
   --and (num_rows > 1000 or num_rows is null)
)
  where :query1m_extended = 'Y'
  order by last_analyzed,owner,obj_type desc,num_rows desc,table_name;
--
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1n
PROMPT
PROMPT       Show tables load factor (estimated)
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
break   on report;
compute sum of NUM_ROWS on report; 
compute sum of est_size_of_data_KB on report;
compute sum of total_size_segments_kb on report;
compute sum of EST_UNUSED_KB on report;
--
column owner                        format a10 wrap;
column table_name                   format a30 wrap;
column Column_name                  format a30 wrap;
column tablespace_name              format a23 wrap;
column num_rows                     format 9,999,999,999   heading "Num|Rows";
column avg_row_len                  format 99999           heading "Avg|Row|Len";
column est_size_of_data             format 999,999,999     heading "Est|Size|Data";
column est_size_of_data_KB          format 999,999,999     heading "Est|Size|Data KB";
column est_size_of_data_MB          format 999,999         heading "Est|Size|Data MB";
column actual_size_of_data          format 999,999,999     heading "Total|Data|Size";
column total_size_segments          format 999,999,999     heading "Total|Size of|Segments";
column total_size_segments_kb       format 999,999,999     heading "Total|Size of|Segments KB";
column total_size_segments_mb       format 999,999         heading "Total|Size of|Segments MB";
column total_size                   format 999,999,999     heading "Total|Size|Of|Table";
column est_unused_kb                format 999,999,999     heading "  Est|Unused|    KB" justify right;
column percent_used                 format 999,999.9       heading "Est|Pct|Used" justify right;
--
--
select * from   -- to allow rownum < ##
  (WITH table_size AS
       (SELECT   owner, segment_name, SUM (BYTES) total_size -- get segment size
           FROM dba_segments
--           FROM dba_extents
           WHERE SEGMENT_TYPE = 'TABLE'
		     AND  (OWNER = :IFSAPPOWNER_UC OR OWNER = :IFSINFO_UC OR OWNER = 'IFS360')
           GROUP BY owner, segment_name)
   SELECT a.owner,table_name, tablespace_name,num_rows,avg_row_len, --  get size of actual data, only as good as the stats are!
  --        num_rows * avg_row_len est_size_of_data,
          num_rows * avg_row_len / 1024 est_size_of_data_KB,
--
  --        b.total_size total_size_segments,
          b.total_size/1024 total_size_segments_kb, 
         (b.total_size - (num_rows * avg_row_len))/1024 EST_UNUSED_KB,
--
  --        estimated size used    /    total size based on dba_extents = percent used space
         ((num_rows * avg_row_len) / (b.total_size) * 100)  percent_used
     FROM dba_tables a, table_size b
--
     WHERE (a.owner = :IFSAPPOWNER_UC or a.owner = :IFSINFO_UC OR a.owner = 'IFS360')  -- for IFS owners
       AND a.table_name in   
         (select table_name from dba_tables where (owner = :IFSAPPOWNER_UC or owner = :IFSINFO_UC OR owner = 'IFS360'))
       AND a.owner = b.owner
       AND a.table_name = b.segment_name -- exclude views listed in dba_tables
  --
  --      limit query to certain percentages    (170 = show all)
       AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 170
  --
  --      limit query to empty tables
  --  and num_rows = 0
  --
  --  Limit to specific tables 
  --  AND a.table_name in ('LANGUAGE_SOURCE_TAB', 'LANGUAGE_SYS_TAB')
  --
  --          limit query to:  size used > 66000 bytes
  -- +++       and ((b.total_size > 200000 and num_rows is not null) or num_rows is null)   
  --    and (b.total_size > 66000 and num_rows is not null) 
      AND (b.total_size > 66000)
  --
  -- enable order by Percent_used desc or asc
   order by  ((num_rows * avg_row_len) / (b.total_size) * 100) asc, table_name)
  --
  -- limit output rows
where rownum < 20000;
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt   BELOW RUNS WHEN VARIABLE :query1n_extended = 'Y';
Prompt   FOR IFS APPOWNER SCHEMA
--
select * from   -- to allow rownum < ##
  (WITH table_size AS
       (SELECT   owner, segment_name, SUM (BYTES) total_size -- get segment size
           FROM dba_segments
--           FROM dba_extents
           WHERE SEGMENT_TYPE = 'TABLE'
		     AND  (OWNER = :IFSAPPOWNER_UC)
           GROUP BY owner, segment_name)
  SELECT '@_shrink_table.sql ' || a.owner  || ' ' || table_name || ';' 
--          num_rows * avg_row_len est_size_of_data,
--          num_rows * avg_row_len / 1024 est_size_of_data_KB,
--
--          b.total_size total_size_segments,
--          b.total_size/1024 total_size_segments_kb, 
--         (b.total_size - (num_rows * avg_row_len))/1024 EST_UNUSED_KB,
--
  --        estimated size used    /    total size based on dba_extents = percent used space
   --      ((num_rows * avg_row_len) / (b.total_size) * 100)  percent_used
     FROM dba_tables a, table_size b
--
     WHERE (a.owner = :IFSAPPOWNER_UC)  -- for IFS owners
       AND a.table_name in   
         (select table_name from dba_tables where (owner = :IFSAPPOWNER_UC))
       AND a.owner = b.owner
       AND a.table_name = b.segment_name -- exclude views listed in dba_tables
  --
  --      limit query to certain percentages  (<70%) 
  --     AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 70
  --
  --      limit query to num_rows based on load factor
  --           less than ### rows, resize if factor < X%
       AND ( (num_rows < 100000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 70)
          OR (num_rows < 200000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 50)
          OR (num_rows < 300000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 50)
          OR (num_rows < 1200000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 25))
  --  Limit to specific tables 
  --  AND a.table_name in ('LANGUAGE_SOURCE_TAB', 'LANGUAGE_SYS_TAB')
  --
  --          limit query to:  size used > 66000 bytes
  -- +++       and ((b.total_size > 200000 and num_rows is not null) or num_rows is null)   
  --    and (b.total_size > 66000 and num_rows is not null) 
      AND (b.total_size > 66000)
  --
  -- enable order by Percent_used desc or asc
   order by  ((num_rows * avg_row_len) / (b.total_size) * 100) asc, table_name)
  --
  -- limit output rows
where rownum < 20000
  and :query1n_extended = 'Y';
--
--
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt   BELOW RUNS WHEN VARIABLE :query1n_extended = 'Y';
Prompt   FOR IFSINFO SCHEMA
Prompt 
--
select * from   -- to allow rownum < ##
  (WITH table_size AS
       (SELECT   owner, segment_name, SUM (BYTES) total_size -- get segment size
           FROM dba_segments
--           FROM dba_extents
           WHERE SEGMENT_TYPE = 'TABLE'
		     AND  (OWNER = :IFSINFO_UC)
           GROUP BY owner, segment_name)
  SELECT '@_shrink_table.sql ' || a.owner  || ' ' || table_name || ';' 
--          num_rows * avg_row_len est_size_of_data,
--          num_rows * avg_row_len / 1024 est_size_of_data_KB,
--
--          b.total_size total_size_segments,
--          b.total_size/1024 total_size_segments_kb, 
--         (b.total_size - (num_rows * avg_row_len))/1024 EST_UNUSED_KB,
--
--          estimated size used    /    total size based on dba_extents = percent used space
--          ((num_rows * avg_row_len) / (b.total_size) * 100)  percent_used
     FROM dba_tables a, table_size b
--
     WHERE (a.owner = :IFSINFO_UC)  -- for IFSINFO owners
       AND a.table_name in   
         (select table_name from dba_tables where (owner = :IFSINFO_UC))
       AND a.owner = b.owner
       AND a.table_name = b.segment_name -- exclude views listed in dba_tables
--
--      limit query to certain percentages  (<70%) 
--     AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 70
--
--      limit query to num_rows based on load factor
--           less than ### rows, resize if factor < X%
       AND ( (num_rows < 100000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 70)
          OR (num_rows < 200000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 50)
          OR (num_rows < 300000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 50)
          OR (num_rows < 1200000 AND ((num_rows * avg_row_len) / (b.total_size) * 100)  < 25))
--  Limit to specific tables 
--  AND a.table_name in ('LANGUAGE_SOURCE_TAB', 'LANGUAGE_SYS_TAB')
--
--          limit query to:  size used > 66000 bytes
-- +++       and ((b.total_size > 200000 and num_rows is not null) or num_rows is null)   
--    and (b.total_size > 66000 and num_rows is not null) 
      AND (b.total_size > 66000)
--
-- enable order by Percent_used desc or asc
   order by  ((num_rows * avg_row_len) / (b.total_size) * 100) asc, table_name )
--
-- limit output rows
where rownum < 20000
  and :query1n_extended = 'Y';
--
--
set echo off;
connect &&sys_connect;
show user;
set feedback off;
set verify off;
set timing off;
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt   Get load factor of certain lob columns
Prompt
connect &&ifsappowner_connect;
show user;
set feedback on;
set verify on;
set timing on;
--
--  Fixed to work with Apps 9
--
select table_name, column_name,
       physical_lob_size * 1024 est_size_of_data_kb,
       allocated_lob_size * 1024 total_size_segments_kb,
       physical_lob_size/allocated_lob_size * 100  percent_used
  from oracle_lob_extents ole
 where ole.table_name not in (select queue_table from user_queue_tables)
 order by table_name, column_name;
--
--
--
set timing off;
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1o
PROMPT
PROMPT       Show top 100 tables by number of data rows
PROMPT       This pulls from dba_tables which relies on database statistics
PROMPT       for the value of num_rows.  
PROMPT
PROMPT       The value of num_rows may not be correct vs. select count (*) from .....
PROMPT
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
set echo off;
clear breaks columns computes;
--
break on report;
compute sum of num_rows on report;
--
column table_name      format a35;
column tablespace_name format a30;
column num_rows        format 999,999,999,999   heading "Num Rows";
--
--
select * from 
(select table_name, tablespace_name,num_rows  
   from dba_tables
  where owner = :IFSAPPOWNER_UC and num_rows is not null
  order by num_rows desc, table_name)
where rownum < 101;
--
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1p
PROMPT
PROMPT       Check for indexes marked by Oracle as corrupt
PROMPT
PROMPT       If there are any indexes marked corrupt you can rebuild them using following statement.
PROMPT       alter index owner.index_name  rebuild;
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;

column owner           format a20;
column table_name      format a35;
column index_name      format a35;
column status          format a15;
--
select owner,table_name, index_name, status
 from dba_indexes 
where status like '%INVALID%' 
   or status = 'UNUSABLE'
order by owner, table_name,index_name; 
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
PROMPT  Indexes marked by Oracle as INVALID or UNUSABLE
PROMPT 
--
clear breaks columns computes;
--
select 'alter index ' || owner || '.' || index_name || ' rebuild;' 
  from dba_indexes 
 where status = 'UNUSABLE' 
 order by index_name; 
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
PROMPT  Look for bad domain indexes
PROMPT
connect &&sys_connect;
show user;
--
select a.*, '________________________________________________________________________________________________'
 from dba_indexes a
 where domidx_status   != 'VALID' 
    or domidx_opstatus != 'VALID';
--
--
--
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1q
PROMPT
PROMPT       Show database links defined 
PROMPT       
PROMPT       Unneeded database links can cause performance issues
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column db_link   format a30;
column username  format a12;
column host      format a55;
column owner     format a15;
column name      format a15;
column value     format a10;
--
--
prompt
prompt Show database links
select * from dba_db_links
 order by 1,2;
-- 
select name, value from v$parameter where name like 'open_links';
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1r
PROMPT
PROMPT       Show Oracle text status
PROMPT
PROMPT       To disable a domain:     exec APPLICATION_SEARCH_SYS.Disable_Search_Domain__('ActiveSeparate');
PROMPT       To drop a domain index:  exec APPLICATION_SEARCH_SYS.Drop_Search_Domain_Index__('ActiveSeparate');
PROMPT
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
--
--
select err_index_name, err_timestamp, err_text
  from ctx_user_index_errors;
--
--
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column search_domain format a25;
column enabled       format a20;
column table_name    format a30;
column index_name    format a30;
--
--  Show defined search domains
--  Works in Apps 7.5
--  Fails in Apps 2004, Apps 8, Apps 9
--
select search_domain, enabled, index_name, table_name
  from search_domain_runtime_tab
 order by enabled desc, search_domain;
--
--
--  Show defined search domains
--  Fails in Apps 7.5
--  Works in Apps 8, Apps 9
--
select search_domain, enabled
  from search_domain_runtime_tab
 order by enabled desc, search_domain;
--
--
connect &&sys_connect;
show user;
--
set echo off;
--
break on report;
compute sum of size_in_mb on report;
--
column entity_name  format a30;
column object_name  format a32;
column dba_segment  format a30;
column Lob_segment  format a30;
column size_in_MB   format 999,999.9;
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt  Search Domain storage usage
Prompt  Written to return rows on versions prior to Apps 8.
Prompt  Will return no rows for Apps 8 but that does not mean no storage is consumed by 
Prompt  text search objects
Prompt
Prompt  Fails on IFS 2004
Prompt
select t.search_domain, t.entity_name, t.index_name, do.object_name, 
       sum(ds.bytes)/1024/1024 Size_in_MB
  from &&ifsappowner..search_domain_runtime t,
       dba_objects do,
       dba_segments ds,
       dba_lobs dl,
       &&ifsappowner..module_tab mt
 where mt.module = 'FNDBAS' 
   and mt.version < '5%'
   and do.object_name like '%' || t.index_name || '%'
   and ds.segment_name = dl.segment_name(+)
   and ds.owner = dl.owner(+)
-- and t.enabled = 'True' 
   and do.owner = :IFSAPPOWNER_UC
   and do.owner = ds.owner
   and do.object_name = ds.segment_name(+)
 group by t.search_domain, t.entity_name,t.index_name,do.object_name
 order by t.search_domain, t.entity_name,t.index_name,do.object_name;
--
PROMPT
PROMPT ---------------------------------------------------------------------;
PROMPT 
Prompt    For Apps 8 need to specify a list of specific domains to gather storage data from
Prompt    Only reports on EDM_FILE_STORAGE%
Prompt
--
select distinct ds.segment_name dba_segment,
       nvl(dl.segment_name,'none') Lob_segment,
       sum(ds.bytes)/1024/1024 size_in_MB
  from dba_objects do,
       dba_segments ds,
       dba_lobs dl
 where (do.object_name like '%EDM_FILE_STORAGE%'
   and do.object_name = ds.segment_name(+)
   and ds.segment_name = dl.table_name(+)
   and ds.owner = dl.owner(+)
   and do.owner = :IFSAPPOWNER_UC
   and do.owner = ds.owner)
   group by ds.segment_name,dl.segment_name
--and t.enabled = 'True' 
union 
select distinct ds.segment_name ds_segment,null,sum(ds.bytes)/1024/1024 size_in_MB
  from dba_segments ds
 where ds.segment_name in (select distinct segment_name from dba_lobs ds2 where ds2.table_name like 'EDM_FILE_STORAGE%')
   and ds.owner = :IFSAPPOWNER_UC
 group by ds.segment_name;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual; 
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1s
PROMPT
PROMPT       Show table names with mixed cases
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
column owner       format a15;
column table_name  format a30;
--
--
--
select owner, table_name from dba_tables 
 where table_name ^= upper(table_name)
   and owner not in ('APEX_030200','APEX_040000','APEX_040200','APPQOSSYS','AUDSYS','CTXSYS','DBSNMP','DMSYS','DSSYS','EXFSYS',
                     'FLOWS_010600','FLOWS_030000','FLOWS_FILES',
                     'GSMADMIN_INTERNAL','MDSYS','ORDPLUGINS','OLAPSYS','ORACLEBIPUB','ORDDATA','ORDSYS','OUTLN',
                     'PERFSTAT','SYS','SYSMAN','SYSTEM','TSMSYS','WKPROXY','WKSYS','WMSYS','XDB') 
 order by 1,2;
--
PROMPT
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1t
PROMPT
PROMPT       Show directories defined
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
column owner           format a15;
column directory_name  format a30;
column directory_path  format a83;
--
--
Select * from dba_directories order by owner, directory_name;
--
PROMPT
PROMPT
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1u
PROMPT
PROMPT       Show ACL related data
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--column owner           format a15;
--column directory_name  format a30;
--column directory_path  format a80;
--

SELECT utl_http.request((SELECT value FROM &&ifsappowner..PLSQLAP_ENVIRONMENT_TAB t WHERE t.name = 'CONN_STR') || '?test=true') FROM dual;


select * from dba_network_acls;

PROMPT
PROMPT
PROMPT       ============================================================
PROMPT       Set 1 Database version, settings, space usage
PROMPT
PROMPT       Query 1v
PROMPT
PROMPT       Show Oracle Auditing related data
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
column enabled_opt    format a16;
column enabled_option format a16;
column entity_name    format a20;
column failure        format a9;
column isdefault      format a10;
column name           format a45;
column policy_name    format a25;
column success        format a9;
column user_name      format a20;
column value          format a80;
column count          format 9,999,999,999 justify right;

--
--  Cleanup routines
--
--  O12 Unified Audit Trail - Full
--BEGIN
--DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;
--DBMS_AUDIT_MGMT.CLEAN_AUDIT_TRAIL(
--audit_trail_type         =>  DBMS_AUDIT_MGMT.AUDIT_TRAIL_UNIFIED,
--use_last_arch_timestamp  =>  FALSE);
--END;
--/
-- 
-- To disable audit policy causing rapid growth of LOB:
--NOAUDIT POLICY ORA_SECURECONFIG;
--NOAUDIT POLICY ORA_LOGON_FAILURES;
--
select name, isdefault, value from v$parameter where name like '%audit%' order by 1;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Rowcount for DBA_AUDIT_TRAIL
PROMPT
select count (*) count from dba_audit_trail;
PROMPT
PROMPT  Data from DBA_STMT_AUDIT_OPTS
PROMPT
SELECT audit_option, success, failure FROM dba_stmt_audit_opts;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Distinct POLICY_NAMES from AUDIT_UNIFIED_POLICIES
PROMPT
select distinct policy_name  from AUDIT_UNIFIED_POLICIES order by policy_name;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Rowcount for UNIFIED_AUDIT_TRAIL
PROMPT
select count (*) count from unified_audit_trail;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Contents of DBA_AUDIT_MGMT_CONFIG_PARAMS
PROMPT
column parameter_name  format a30;
column parameter_value format a20;
PROMPT
PROMPT Verify if cleanup has been initialized by running the following. 
PROMPT Cleanup has not yet been initialized if there are no 
PROMPT 'DEFAULT CLEAN UP INTERVAL' parameters listed in the output
PROMPT
PROMPT  Fails in Oracle 9, 10.2
PROMPT
select * from dba_audit_mgmt_config_params
 order by 1;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Is Auditing clean-up enabled?
PROMPT
set serveroutput on;
--
--  Fails in Oracle 9, 10.2
--
BEGIN
 IF 
   DBMS_AUDIT_MGMT.IS_CLEANUP_INITIALIZED(DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD)
 THEN
   DBMS_OUTPUT.PUT_LINE('AUD$ is initialized for clean-up');
 ELSE
   DBMS_OUTPUT.PUT_LINE('AUD$ is not initialized for clean-up.');
 END IF;
END;
/
PROMPT
PROMPT  Data from AUDIT_UNIFIED_ENABLED_POLICIES
PROMPT
PROMPT  12.1  ENABLED_OPT
PROMPT  
PROMPT  Enabled option of the audit policy. Possible values:
PROMPT  BY: For policies that are enabled on users
PROMPT  EXCEPT: For policies that are enabled on users
PROMPT  INVALID: For policies that are not enabled on either users or roles
PROMPT  This column is deprecated in Oracle Database 12c Release 2 (12.2.0.1), and may be removed in a future release.
PROMPT  
PROMPT  12.2  ENABLED_OPTION
PROMPT  
PROMPT  Enabled option of the audit policy. Possible values:
PROMPT  BY USER: For policies that are enabled on users
PROMPT  EXCEPT USER: For policies that are enabled on users
PROMPT  BY GRANTED ROLE: For policies that are enabled on roles
PROMPT  INVALID: For policies that are not enabled on either users or roles
PROMPT  This column is available starting with Oracle Database 12c Release 2 (12.2.0.1). 
PROMPT
select * from AUDIT_UNIFIED_ENABLED_POLICIES;
PROMPT
PROMPT
PROMPT  Data from DBA_AUDIT_POLICIES
PROMPT
SELECT * from DBA_AUDIT_POLICIES;
PROMPT
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2a
PROMPT
PROMPT       Object Count - all Oracle users
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
set timing off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column owner       format a25;
column object_type format a20 heading 'Object Type';
column count       format 999,999 justify right;
--
break on owner skip 1 on report;
compute sum of count on report;
--
select owner, object_type, status, count(*) count
  from dba_objects
 group by owner,object_type,status
 order by owner,object_type,status;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2b
PROMPT
PROMPT       List invalid database objects - all Oracle users 
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column owner       format a25 heading 'Owner';
column object_type format a20 heading 'Object Type';
column object_name format a40 heading 'Object Name';
column status      format a10 heading 'Status';
--
select owner, object_type, object_name, status from dba_objects 
 where status != 'VALID'
 order by 1,2,3,4;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2c
PROMPT
PROMPT       List Contents Of Module_tab - Installed Components
PROMPT       Review against various caches
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
set echo off;
clear breaks columns computes;
--
column description   format a15;
column dictionary_component format a8 heading 'COMP';
column module               format a10;
column module_tab           format a8 heading 'MODULE';
column name                 format a50;
column patch_version        format a22;
column po_module            format a10 heading 'PO Module';
column rst_module           format a10 heading 'RPT Module';
column upgrade_from_version format a15;
column version              format a15;
column version_desc         format a82 newline;
column rowkey noprint;
--
--
set echo on;
--
select count (*) from module_tab where module > 'A';
--
--
select * from module_tab where module > 'A' order by 1;
--
--
--
--  For Apps 8 obsolete or previously dropped components should not be in module_tab
--
set echo off;
column version_desc clear;
column version_desc format a20;
--
select module, name, version, version_desc, reg_date 
  from module_tab 
 where (version is null or version_desc is null)
   and module > 'A'
 order by 1;
--
--
PROMPT
PROMPT  These components have been dropped but still have an entry in module tab
PROMPT  Drop module tab entry in pre or post drops during upgrade.
PROMPT
select module, name, version, version_desc, reg_date 
  from module_tab 
 where (version is null or version_desc is null)
   and module > 'A'
   and module not in 
--
   ('ACADC','ACCRUB','APPSRB','APPSRW','BARSRV','BATCH', 'BOARD', 'BOARDW','BUDPRB','BUSPER','BUSPEW',
   'CALLCX','CFGBBW','CFGCHW','CHMGMW','CMATCH','COMPET','CONNCT','COSTW', 'CROMFW','CRPW',  'CURREV',
   'CUSSCW','DAMIEN','DEMANW','DEMENT','DEMORD','DEMSTO','DISORW','DMD',   'DMFND', 'DMHR',  'DMM',   
   'DOCMAD','DOCMM', 'DOPW',  'DTS',   'DWGIMP','ENGINT','ENTERB','ENTKIT','EQUIPX','EQUIW', 'EQUMON',
   'EURKIT','EXFILE','FINREW','FIXASW','FNDAS', 'FNDBI', 'FNDBM', 'FNDCLI','FNDCN', 'FNDCON','FNDDEP',
   'FNDDES','FNDEE', 'FNDEXT','FNDINF','FNDJBS','FNDLOC','FNDMOB','FNDQUA','FNDSEC',
   'FNDSER','GENLEB','HIDEIM','HPM',   'HRMBAS','HRMBAW','IIKIFS','INTLEB','INTLEW','INVENM','INVOIB',
   'INVWLC','JOBSEC','KANWLC','KPIVW', 'LICMAN','MATCAD','MATCAW','MFGCHM','MLIB',  'MLIBW', 'MMAINT',
   'MNTAIP','MPCCOW','MROMFW','NATSTW','OEEW',  'OEEX',  'ONLIF', 'ONLINE','ONLINW','ORDERM','ORDSTW',
   'OUTSRV','PACADC','PARTCW','PAYROL','PCMWLC','PCMX',  'PDMCAD','PDMPRW','PDNSKW','PERDEB','PERLED',
   'PLACAD','PLADEW','PLASMB','PRBP',  'PRCC',  'PREPRD','PRJCAD','PRJPPP',
   'PROAUW','PURCHM','PURMOB','PURWLC','QUAMAW','REDIRE','REGNET','REGTIM','RRPW',  'SAINT', 
   'SALREV','SALREW','SCHED', 'SCONF', 'SERORD','SFA',   'SHPEMP','SHPEMW','SHPREP','SICADM','SICADW','SRVAGW',
   'STRAAD','STRAAW','SUBAFP','SUPSCW','SWCADC','TAS',   'TAXLEB','TIMMOB','TXTBBW','TXTSER','TXTSEW',
   'VIMFCW','VIMMRW','VIMW',  'VIRRTT','VMODSY','VMOGSS','VMOSAR','VMOSFA','VMOSFW','VMOSPW','VMOXSY',
   'WEBKIT','WMAINT','WSCOPW')
 order by 1;
--
--
set echo on;
--  Check the order of patch deployment
--
select module, name, reg_date  
  from module_tab 
 where module < 'A' order by 3, 1 desc;
--
set echo off;
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for Packages w/o Package Body and reverse
PROMPT
select object_name 
from (select object_name from user_objects where object_type='PACKAGE' and object_name not like '%COMPONENT_%' 
                                                                       and object_name not like 'RPT_PKG_%'
minus select object_name from user_objects where object_type='PACKAGE BODY');
--
select object_name 
from (select object_name from user_objects where object_type='PACKAGE BODY'
minus select object_name from user_objects where object_type='PACKAGE');
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for component remnants in Dictionary_sys_tab
PROMPT  Ignore FNDEV for Apps 7 base/sp1/sp2
PROMPT  Ignore CHGCHM 1 found for 2004
PROMPT
select distinct d.module dictionary_component,
       count(d.module)dictionary_count, 
       m.module module_tab,
       m.version version, 
       m.version_desc version_desc,
       reg_date
  from dictionary_sys_tab d,module_tab m
 where d.module = m.module(+)
   and d.module not in ('FNDSER')
   and (version is null or version_desc is null)
 group by d.module,m.module,m.version,m.version_desc, reg_date 
 order by 1;
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for component remnants in Language_context_tab
PROMPT
PROMPT  Valid for 2004 SP5 or later?  No result set
PROMPT  Valid for Apps 7 Base and later
PROMPT
select distinct l.module language_context,
       count(l.module)context_count, 
       m.module module_tab,
       m.version version, 
       m.version_desc version_desc,
       reg_date
  from language_context_tab l,
       module_tab m
 where l.module = m.module(+)
   and l.module not in ('FNDSER')
   and (version is null or version_desc is null)
 group by l.module,m.module,m.version,m.version_desc, reg_date
 order by 1;
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for component remnants in pres_object_tab
PROMPT
select distinct po.module po_module,
       count(po.module)context_count,
       m.module module_tab,
       m.version version,
       m.version_desc version_desc,
       reg_date
  from pres_object_tab po,module_tab m
 where po.module = m.module(+)
   and po.module not in ('FNDSER')
   and (version is null or version_desc is null)
 group by po.module,m.module,m.version,m.version_desc, reg_date
 order by 1;
--
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for component remnants in report_sys_tab
PROMPT
PROMPT  Valid for Apps 7 
PROMPT
select distinct rst.module rst_module,
       count(rst.module) rst_count,
       m.module module_tab,
       m.version version,
       m.version_desc version_desc,
       reg_date
  from report_sys_tab rst,
       module_tab m
 where rst.module = m.module(+)
   and rst.module not in ('FNDSER')
   and (version is null or version_desc is null)
 group by rst.module,m.module,m.version,m.version_desc, reg_date
 order by 1;
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for scheduled jobs with no component in module_tab
PROMPT  This will cause problems in Apps 8
PROMPT
PROMPT  Potential fix apply bug 111810 (in core 8.0 SP1+) then e.g.:
PROMPT  Batch_SYS.Rem_Cascade_Batch_Schedule_Met('OPERATIONAL_QUESTIONS_API.DELETE_OLD_PLANNED_OP__');
PROMPT
PROMPT  Fails in Apps 2003
PROMPT
--
set echo off;
column description        format a65;
column check_day          format a8  heading 'Check|Day';
column check_executing    format a10 heading 'Check|Executing';
column rowversion         format a10;
column schedule_method_id format 99999 heading 'Schedule|Method|ID';
column single_execution   format a10   heading 'Single|Execution';
column rowkey noprint;
select bsmt.*,
'_______________________________________________________________________________________________________________________________________' 
from  batch_schedule_method_tab bsmt,module_tab m
where bsmt.module = m.module(+)
  and (version is null or version_desc is null)
order by 1;
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT  Look for scheduled jobs that reference a package 
PROMPT  that does not exist
PROMPT
set echo off;
select a.method_name
  from batch_queue_method_tab a
 where not exists
  (select 1 
     from dba_objects ao,
          batch_queue_method_tab b
    where upper(substr(b.method_name, 1 , instr(b.method_name, '.')-1)) = ao.object_name
      and ao.object_type = 'PACKAGE'
      and a.method_name = b.method_name)
 order by 1;
 
PROMPT
PROMPT  ---------------------------------------------------------;
PROMPT
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2d
PROMPT       Obsolete IFS UserIds
PROMPT
PROMPT
PROMPT       System defined users in 2003-2 (?/SP3/?) - Obsolete in 2004
PROMPT         FNDAS% 
PROMPT
PROMPT       System defined users in 2004 SP3/SP4/SP5 
PROMPT       Obsolete in 7.0 
PROMPT         FNDEXT% 
PROMPT         IFSAPPEN
PROMPT         IFS_PRINT_AGENT
PROMPT
PROMPT       -----;
PROMPT
PROMPT       See if any Obsolete IFS UserIds exist in this DB
PROMPT
connect &&sys_connect;
show user;
--
select username from dba_users
 where username in ('IFS_PRINT','IFS_PRINT_AGENT','IFSAPPEN','IFSAPPSYS','IFS_BM','IFSBM','IFS_SM')
    or username like 'FNDAS%'
    or username like 'FNDEXT%'
    or username like 'VMO%'
 order by username;
--
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2e
PROMPT
PROMPT       Objects deployed in SYS or SYSTEM schema 
PROMPT       but are also in the IFS Apps related schemas
PROMPT
PROMPT       Objects deployed in Appowner schema and IFSINFO
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
set echo off;
clear breaks columns computes;
--
break  on report;
column owner       format a25;
column object_name format a30;
column object_type format a30;
--
column table_owner format a25;
column index_name  format a30;
column table_name  format a30;
PROMPT
PROMPT  Look for objects that are deployed in IFS Apps related schemas
PROMPT  but are also in the SYS or SYSTEM schema
PROMPT
--
select object_id, owner, object_name, object_type, created
  from dba_objects 
 where (owner like 'FNDAS%' 
     or owner like 'FNDEXT%' 
     or owner = :IFSAPPOWNER_UC
     or owner = :IFSINFO_UC
     or owner in ('IFS_PRINT','IFS_PRINT_AGENT','IFSAPPEN','IFS360','IFSAPPSYS'))
    and object_name in 
(
select object_name from dba_objects b
 where owner = 'SYSTEM' 
    or owner = 'SYS' 
)
UNION
select object_id, owner, object_name, object_type, created
  from dba_objects where owner in ('SYSTEM','SYS') 
   and object_name in 
(
select object_name from dba_objects 
  where (owner like 'FNDAS%' 
      or owner like 'FNDEXT%' 
      or owner = :IFSAPPOWNER_UC 
      or owner = :IFSINFO_UC
      or owner in ('IFS_PRINT','IFS_PRINT_AGENT','IFSAPPEN','IFS360','IFSAPPSYS'))
)
order by object_name, object_type, owner;
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Look for objects that are deployed in IFS Apps owner schema
PROMPT  but are also in the IFSINFO schema
PROMPT
select object_id, owner, object_name, object_type, created
  from dba_objects a
 where owner = :IFSAPPOWNER_UC
   and object_name in 
(
select object_name from dba_objects b
 where owner = :IFSINFO_UC
   and a.object_type = b.object_type 
)
UNION
select object_id, owner, object_name, object_type, created
  from dba_objects a
 where owner = :IFSINFO_UC
   and object_name in 
(
select object_name from dba_objects b
 where owner = :IFSAPPOWNER_UC
   AND a.object_type = b.object_type 
)
order by object_name, object_type, owner;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT   Show indexes owned by other than the table owner
PROMPT
select owner, index_name, table_owner, table_name 
  from dba_indexes 
 where owner ^= table_owner
 order by table_owner, table_name, owner, index_name;
--
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2f
PROMPT
PROMPT       Look for remnants of Oracle 8 Enterprise Manager objects found
PROMPT       owned by IFSAPP.
PROMPT       
PROMPT       Run _drop_dba_em_evt_smp_objects.sql during upgrade 
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
col object_name format a40;
--
--
select object_type, object_name, created 
  from user_objects 
 where object_name like 'EVT%' 
    or object_name like 'SM%' 
    or object_name like 'MGM%' 
 order by 1,2,3;
--
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2g
PROMPT
PROMPT       Determine if foreign key constraints exist in IFS schema.
PROMPT
PROMPT       Foreign Key constraints may be result of obsolete code.
PROMPT       IFS will investigate this if any rows are returned
PROMPT       ============================================================
PROMPT
set echo off;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
col owner           format a10;
col constraint_name format a30;
col constraint_type format a15 heading 'Constraint|Type';
col table_name      format a30;
PROMPT
PROMPT  Constraints NOT related to Custom Objects
PROMPT
select distinct owner,status,validated,constraint_type,deferred,count (*)  
  from user_constraints
 where constraint_type = 'R'
   and (constraint_name like '%FK%' 
   and  constraint_name not like '%CFK%' 
   and substr(constraint_name, 1, 4)  not in ('VMO_', 'MIGR', 'MTK_', 'TRAN'))
 group by owner,status,validated,constraint_type,deferred
 order by owner,status,validated,constraint_type,deferred;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT  Constraints that ARE related to Custom Objects
PROMPT
select owner,constraint_name,status,table_name
  from user_constraints
 where constraint_type = 'R'
   and (constraint_name like '%FK%'
   and substr(constraint_name, 1, 4)  not in ('VMO_', 'MIGR', 'MTK_', 'TRAN'))
 order by 3,1,2;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT  Look for tables without a Primary Key defined
PROMPT  Excludes tables known to NOT have PKs in Apps 8 SP1+ (obtained from fresh install 80sp1+)
PROMPT
connect &&sys_connect;
show user;
--
select table_name
  from dba_tables
where (table_name like '%_TAB' OR table_name like '%_RPT')
   and owner = :IFSAPPOWNER_UC
   and table_name not like 'MTK%'
   and table_name not like 'MIGRATION%'
   and table_name not in (
'AD_IFS_USER_GROUP_USER_TAB',
'AUTHORITY_TIME_TAB',
'BI_DUAL_TAB',
'BUD_PRO_PERIOD_FOCUS_TEMP_TAB',
'CHANGE_OBJECT_VALUE_TEMP_TAB',
'CONFIG_PARAM_DISTINCT_JMS_TAB',
'COLLECTIVE_VOUCHER_TEMP_TAB',
'CUST_ORD_INVO_STAT_AGG_TMP_TAB',
'DATA_POINT_TMP_TAB',
'DAY_TYPE_LIST_TAB',
'DELIVERY_QTY_STAT_AGG_TMP_TAB',
'DOCISSUE_INCONSISTENT_DATA_TAB',
'DOP_ORDER_MESSAGE_TMP_TAB',
'ECR_OBJECT_CONN_TAB',
'EMPLOYEE_NAME_CONFIGURATOR_TAB',
'EXT_FILE_XML_FILE_TAB',
'EXT_INC_INV_PAY_PLAN_TEMP_TAB',
'EXT_LOAD_PAYMENT_TEMP_TAB',
'EXT_PAYMENT_INV_TMP_TAB',
'FAILED_TRANSACTION_TEMP_TAB',
'FND_USER_LICENSE_IMPACT_TAB',
'FND_WORKFLOW_CONNECTION_TAB',
'FUNC_AREA_CONFLICT_CACHE_TAB',
'FUNC_AREA_SEC_CACHE_TAB',
'HR_PRJ_HOURS_AND_COST_TEMP_TAB',
'HR_PRJ_REVENUE_TEMP_TAB',
'IC_DEL_MIG2_TAB',
'IMPORT_PROCESS_TAB',
'MATCHED_INVOICE_ATTR_TAB',
'MIS_FA_CAL_TMP_TAB',
'OLC_LOAD_PARAMS_TMP_TAB',
'ORD_AGG_STAT_LOG_TMP_TAB',
'ORDERED_OPERATIONS_TEMP_TAB',
'PART_COST_BUCKET_ONE_TAB',
'PART_COST_BUCKET_TAB',
'PAYMENT_PLAN_TEMP_TAB',
'PAYMENT_UNUSED_AMOUNTS_TAB',
'PERIODICAL_CALCULATION_TAB',
'POS_ACC_RESULT_TEMP_TAB',
'POSITIONS_TEMP_TAB',
'POSTING_CTRL_DETAIL_TEMP_TAB',
'PRES_OBJECT_SECURITY_SNAP_TAB',
'PRES_OBJECT_SNAP_TAB',
'PRINT_INVOICE_TAB',
'PRODUCTION_RCPT_MSG_TMP_TAB',
'PROJECT_PROD_STR_TEMP_TAB',
'PROJECT_TRANS_WEEK_TAB',
'PS_INCOMING_FR_ERROR_TAB',
'PS_SHIP_VIA_FREIGHT_TAB',
'REPORT_HIDDEN_COLUMN_TAB',
'REPORT_LANG_FORMAT_DEF_TAB',
'REPORT_LAYOUT_FILENAMES_TAB',
'REPORT_TEMPL_DEF_RPT',
'RESOURCE_LOAD_TEMP_TAB',
'RESULT_SUPPRESS_TAB',
'RESULT_TRANSACTION_ROW_TAB',
'SECURITY_SYS_EXPANDED_ROLE_TAB',
'SECURITY_SYS_REFRESH_USER_TAB',
'SHIPMENT_IN_TAB',
'SHOP_ORDER_COST_BUCKET_TMP_TAB',
'SHOP_ORDER_MESSAGE_TMP_TAB',
'SHPEMP_TRANSACTION_TAB',
'SOD_CACHE_TAB',
'STRUCT_HEAD_BACK_TAB',
'STRUCT_ITEM_BACK_TAB',
'STRUCT_LEVEL_BACK_TAB',
'TEMP_DOP_COST_ELEMENT_TAB',
'TEMP_INV_MATCHING_TAB',
'TEMP_INVOICING_ADVICE_TAB',
'TEMP_PDMPRO_COST_ELEMENT_TAB',
'TEMP_PO_NUMBER_TAB',
'TEMP_RECEIPT_REF_TAB',
'TEMPL_STRUCTURE_TEMP_TAB',
'TEXT_TRANSLATION_STOP_LIST_TAB',
'TIME_PERS_DIARY_DETAIL_TAB',
'TIMREP_TRANSACTION_TAB',
'TMP_CUST_PAY_JOUR_RPT',
'TMP_SUPP_PAY_JOUR_RPT',
'UPGRADE_ACTIVITY_LOGGING_TAB',
'USER_OBJECTS_SNAPSHOT_TAB',
'VIM_STR_TEMP_TAB',
'VMO_BASE_SYNC_INDEX_TAB',
'VMO_BASE_SYNC_PACKAGE_TBL_TAB',
'VMO_BASE_SYNC_TRIGGER_TBL_TAB',
'VMO_BASE_SYNC_VIEW_TAB',
'VMO_TEMP_LOGTRUNC_TAB',
'VMO_TEMP_SYNC_SCOPE_TAB',
'VMO_TEMP_SYNC_SESSION_TAB',
'VMO_TEMP_SYNC1_TAB',
'VMO_TEMP_SYNC2_TAB',
'VMO_TEMP_SYNC3_TAB',
'VMO_TEMP_SYNC4_TAB',
'VMO_TEMP_SYNC5_TAB',
'VMO_TEMP_TRIGGER_TAB',
'WORK_SCHED_EMERGENCY_DESC_TAB',
'WORK_SCHED_INCREMENT_DESC_TAB',
'WORK_TIME_CAL_DATA_TAB',
'XLR_MV_HELP_TAB',
'XLR_SESSION_PARAM_VALUE_TAB',
'XLR_USER_DEP_TAB',
'XLR_MV_REF_HELP_TAB')
minus
select table_name
  from dba_indexes
where owner = :IFSAPPOWNER_UC
   and table_name in (select table_name
                        from dba_constraints
                       where owner = :IFSAPPOWNER_UC
                         and constraint_type = 'P');
--minus
--select table_name
--  from dba_indexes
--where owner = :IFSAPPOWNER_UC
--   and index_name like '%_PK'
--minus
--select table_name
--  from dba_indexes
--where  owner = :IFSAPPOWNER_UC
--	and index_name like '%_PK_IX';
--
--
PROMPT       ============================================================
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2h
PROMPT
PROMPT       Show job queue setup data (Batch Queue Configuration)
PROMPT       ============================================================
PROMPT
set echo off;
set timing off;
set feedback off;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column name           format a40;
column value          format a60;
column isdefault      format a10;
--
column queue_id       format 999 heading 'Queue|ID';
column description    format a45;
column process_number format 999 heading 'Number of|Processes|Assigned';
column active         format a10;
column execution_plan format a55;
column lang_code      format a5  heading 'Lang|Code';
column v$job_queue_processes    format a25;
column rowkey noprint;
--
column method_name    format a67;
--
column active         format a6;
column schedule_name  format a70;
column count          format 9,999,999;
--
--
PROMPT
PROMPT
Prompt  IFS Demands for Queues vs. Oracle Available Queues
Prompt
Prompt  v$job_queue_processes should be at least 5 above the sum of IFS Queue processes defined
Prompt
Prompt
select substr(value, 1, 22) "v$job_queue_processes", queues "Sum of IFS Job Queue Processes"
  from v$parameter,
       (select sum(process_number) queues
          from batch_queue_tab
         where active = 'TRUE')
  where name = 'job_queue_processes';
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
set echo on;
set feedback on;
select * from batch_queue_tab order by 1;
-- 
-- 
select * from batch_queue_method_tab  
 order by queue_id,method_name;
-- 
--  
select schedule_name, active, execution_plan
  from batch_schedule_tab
 where execution_plan ^= 'ASAP'
 order by schedule_name, execution_plan;
-- 
-- 
select distinct schedule_name, count (*) count 
  from batch_schedule_tab
 where execution_plan = 'ASAP'
 group by schedule_name
 order by schedule_name;
-- 
-- 
select * from batch_sys_tab order by 1;
--
--
set echo off;
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2i
PROMPT
PROMPT       Background job logs by Job State 
PROMPT
PROMPT       Jobs in status Error and Warning do not purge automatically.  
PROMPT       Customers should clean this up on old version prior to upgrade.
PROMPT
PROMPT       Jobs with errors should be reviewed to determine why they are
PROMPT       erring out.
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
set timing off;
connect &&ifsappowner_connect;
show user;
--
set feedback off;
clear breaks columns computes;
--
break on state skip 2 on report;
compute sum of Count on report;
compute sum of Count on state;
--compute min of oldest on state;
--compute min of newest on state;
--
column action           format a35;
column execution_plan   format a50;
column objversion       format a130;
column state            format a9  heading 'Job|State';
column procedure_name   format a65 heading 'Procedure Name';
column queue_id         format 99  heading 'Queue|ID';
column Count            format 99,999,999 justify right;
column Oldest           format a9;
column Newest           format a9;
column Min_Elapsed_Mins format 9999.9 heading 'Min|Elap|Mins' justify right;
column Max_Elapsed_Mins format 9999.9 heading 'Max|Elap|Mins' justify right;
column Avg_Elapsed_Mins format 9999.9 heading 'Avg|Elap|Mins' justify right;
--
--
--
select to_number(Fnd_Setting_API.Get_Value('KEEP_DEFJOBS')) Keep_Defjobs_days from dual;
select to_number(Fnd_Setting_API.Get_Value('KEEP_DEFJOBS_ERROR')) Keep_Defjobs_Error_days from dual;
select to_number(Fnd_Setting_API.Get_Value('KEEP_DEFJOBS_WARNING')) Keep_Defjobs_Warning_days from dual;
set feedback on;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Status of retained background job logs
PROMPT
select distinct state,
       procedure_name,
       queue_id,
       count (*) count, 
       to_char(min (executed)) oldest,
       to_char(max (executed)) newest,
       min ((executed - started) * 1440) Min_Elapsed_Mins,
       max ((executed - started) * 1440) Max_Elapsed_Mins,
       avg ((executed - started) * 1440) Avg_Elapsed_Mins
  from transaction_sys_local_tab
 group by state, procedure_name,queue_id
 order by state, procedure_name,queue_id;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Summary status of retained background job logs
PROMPT
Break on year skip 1 on report;
compute sum of count on report;
column year heading 'Year|Executed';
column count format 99,999,999;
column procedure_name   format a55 heading 'Procedure Name';
column state format a11 heading 'Background|Job Status';
--
select distinct extract(year from executed) year,
       state, 
       count (*) count
  from transaction_sys_local_tab
 group by extract(year from executed), state
 order by extract(year from executed), state;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Summary status of Database_Sys background job logs
PROMPT
clear breaks;
--
--
select distinct state,
       procedure_name,
       queue_id,
       count (*) count, 
       min (executed) oldest,
       max (executed) newest,
       min ((executed - started) * 1440) Min_Elapsed_Mins,
       max ((executed - started) * 1440) Max_Elapsed_Mins,
       avg ((executed - started) * 1440) Avg_Elapsed_Mins
  from transaction_sys_local_tab
 where upper(procedure_name) like '%Database_Sys%'
 group by state, procedure_name,queue_id
 order by state, procedure_name,queue_id;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Summary status of background job logs with "CLEAN" in the PROCEDURE_NAME
PROMPT
clear breaks;
--
--
select distinct state,
       procedure_name,
       queue_id,
       count (*) count, 
       min (executed) oldest,
       max (executed) newest,
       min ((executed - started) * 1440) Min_Elapsed_Mins,
       max ((executed - started) * 1440) Max_Elapsed_Mins,
       avg ((executed - started) * 1440) Avg_Elapsed_Mins
  from transaction_sys_local_tab
 where upper(procedure_name) like '%CLEAN%'
 group by state, procedure_name,queue_id
 order by state, procedure_name,queue_id;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Summary status of cleanup jobs for IFS 2003 and earlier
PROMPT
PROMPT For IFS 2003
PROMPT Not accurate for IFS 7.5
PROMPT 
PROMPT    'P', 'Pending'
PROMPT    'W', 'Working'
PROMPT    'A', 'Active'
PROMPT    'B', 'Broken'
PROMPT    'R', 'Removed'
PROMPT 
--
select * from batch_job
 where (upper(execution_plan) like '%BATCH/_SYS.FND/_HEAVY%' escape '/' 
     or upper(execution_plan) like '%BATCH/_SYS.FND/_LIGHT%' escape '/');
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Show scheduled batch jobs
PROMPT 
column action format a125;
--
select bj.*, '____________________________________________________________________________________________________________________________'  
  from batch_job bj
 order by action;
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT Show batch_schedule_tab rows without a matching batch_schedule_method row
PROMPT 
--  
--
select bs.*, '____________________________________________________________________________________________________________________________'  
 from batch_schedule_tab bs
 where not exists (select 1 from batch_schedule_method bsm
                    where bs.schedule_method_id = bsm.schedule_method_id);
--
PROMPT       ============================================================
PROMPT
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2j
PROMPT
PROMPT       List IFS Events that call code
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column event_enable  format a8 heading 'Event|Enabled';
column action_enable format a8 heading 'Event|Action|Enabled';
--
--
--
select fe.event_enable event_enable, t.*,
       '__________________________________________________________________________________________________________________________'
  from FND_EVENT_ACTION t
  join FND_EVENT fe
    on fe.event_lu_name      = t.event_lu_name
   and fe.event_id           = t.event_id
 where fnd_event_action_type_db = 'EXECUTEONLINESQL'
   and dbms_lob.instr(action_parameters,'_API') >0
 order by t.event_lu_name, t.event_id, t.action_number;
--
PROMPT       ============================================================
PROMPT
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2k
PROMPT
PROMPT       Database triggers by owner, status
PROMPT
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column owner format a20;
column count format 999;
--
--select *
--from all_triggers
--where upper(table_name) = 'CUSTOMER_ORDER_TAB' 
--
--
--
--  Look for triggers for all Oracle users that are defined against IFSAPP tables
--
select distinct owner, status, count(*) count
  from dba_triggers
 where table_owner = :IFSAPPOWNER_UC
 group by owner,status
 order by owner,status;
--
PROMPT       ============================================================
PROMPT
PROMPT       Set 2 IFS Apps Objects
PROMPT
PROMPT       Query 2l
PROMPT
PROMPT       Ping test for PLSQL Access Provider
PROMPT       Should return ‘1’, ping successful. 
PROMPT       If it returns ‘0’, we could not ping it.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
set timing on;
clear breaks columns computes;
--
--  Fails in Oracle 9
--
select Plsqlap_Server_API.Ping_Result__ FROM dual;
--
set timing off;
PROMPT       ============================================================
PROMPT
PROMPT       Set 2 IFS Licensing details
PROMPT
PROMPT       Query 2m
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
column value         format a50;
column version       format a10;
column patch_version format a22;
column rowkey noprint;
--
select * from FND_LICENSE_TAB order by 1;
--
--  Hash values
--  Apps 9
--
--  See view FND_LICENSED_USER for users that do not consume a license
--
--  Apps 9
--  UPD3        692963401  
--  UPD4        192287781  
--  UPD5        192287781  
--  UPD6        416778297  
--  UPD7-10     87987530  
--  

--  For Apps 9 UPD7-10 following are excluded from licenses used count:
--  IFSAPP or however appowner is defined
--  BAESSERVER 
--  CBSSERVER 
--  DEMANDSERVER 
--  DOCVUETICKETUSER 
--  IAL_USER
--  IFS_IOT_GATEWAY
--  IFSADMIN 
--  IFSANONYMOUS 
--  IFSCONNECT 
--  IFSMOBILITY 
--  IFSMONITORING 
--  IFSPLSQLAP 
--  IFSPRINT 
--  IFSSYNC 
--  IFSUSER 
--  IFSWEBCONFIG 
--  SALESANDMARKETING 
--
--  Apps 10
--  Beta5      446889930
--  UPD1-2     499917825
--
--  For Apps 10 UPD1-2 following are excluded from licenses used count:
--  Sys_Context('FNDSESSION_CTX', 'APP_OWNER')
--  BAESSERVER
--  BCINTUSER
--  CBSSERVER
--  DEMANDSERVER
--  DOCVUETICKETUSER
--  IFS_IOT_GATEWAY
--  IFSADMIN
--  IFSCONNECT
--  IFSMOBILITY
--  IFSMONITORING
--  IFSPLSQLAP
--  IFSPRINT
--  IFSSCHEDULING
--  IFSSYNC
--  IFSUSER
--  SALESANDMARKETING
--
select module, version, patch_version from module_tab where module = 'FNDBAS';
--
select  FND_LICENSE_SYS.COMPUTE_VIEW_HASH('&&ifsappowner','FND_LICENSED_USER') hash from dual;
--
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3a
PROMPT
PROMPT       Data storage used for Materialized View Logs
PROMPT
PROMPT       ============================================================
PROMPT
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
break on report;
compute sum of MB_used_for_MLOG$ on report;
--
column MB_used_for_MLOG$ format 9,999,999.9;
column segment_name      format a30;
-- 
select distinct segment_name, 
       ceil(sum(bytes)/1024/1024) MB_used_for_MLOG$
  from dba_segments 
 where segment_name LIKE 'MLOG$%'
 group by segment_name
 order by segment_name;
-- 
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3b
PROMPT
PROMPT       Object count for MTK objects
PROMPT
PROMPT       Exclude specific IFS Core product objects list as of 8.0 SP1 
PROMPT       (Add additional excludes to allversion_mtk_dr.sql)
PROMPT
PROMPT       _CNT objects are from DAMIEN
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column owner format a30;
column Count_of_MTK_Objects format 999,999 head 'Count of|MTK Objects';
--
select distinct owner,object_type, count (*) Count_of_MTK_Objects 
  from dba_objects 
 where (object_name like 'MTK_%' 
     or object_name like 'MIGRATION_%'
     or object_name like 'TCM_%'
     or object_name like '%_CNT')
    and object_name not in ('TAX_TEMPLATE_BASIC_CNT','WORK_ADD_PARA_REVAL_ACCNT','TCM_REP_ENU_PAY_API','TCM_REP_ENU_INV_API')
  group by owner,object_type
  order by owner,object_type;
-- 
--
--
Prompt  Show data storage used for MTK objects
-- 
column MB_used_for_MTK_Objects format 9,999,999.9 head 'MB Used by|MTK Objects';
--
select distinct owner,ceil(sum(bytes)/1024/1024) MB_used_for_MTK_Objects
  from dba_segments 
 where (segment_name like 'MTK_%' 
     or segment_name like 'MIGRATION_%'
     or segment_name like 'TCM_%' 
     or segment_name like 'FNDMIG%')
    and segment_name not in ('TAX_TEMPLATE_BASIC_CNT','WORK_ADD_PARA_REVAL_ACCNT','TCM_REP_ENU_PAY_API','TCM_REP_ENU_INV_API')
  group by owner
  order by owner;
-- 
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3c
PROMPT
PROMPT       Use of History Logging.
PROMPT
PROMPT       List tables that History Logging is enabled on.
PROMPT       ============================================================
PROMPT
set echo off;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
PROMPT 
PROMPT  List tables that History Logging is enabled on.
-- 
column activate_cleanup format a10    heading 'Activate|Cleanup';
column days_to_keep     format 999999 heading 'Days|To|Keep';
column target_oldest    format a10    heading 'Target|Oldest';
column table_name       format a30;
column rowkey noprint;
--
--
select hst.*,  to_char(sysdate - hst.days_to_keep) target_oldest
  from history_setting_tab hst
 order by table_name;
--
--
--
PROMPT 
PROMPT --------------------------------------------------------------------------;
PROMPT 
PROMPT  Data volume by table for tables that have History Logging enabled.
--
--
break   on report;
compute sum of count on report;
--
column count    format 999,999,999 justify right;
column days_old format 99,999 heading 'Days|Old';
--
--
--
select distinct hst.table_name,
       module,       
       sysdate - min(hlt.rowversion) days_old,
       min(time_stamp) oldest,
       max(to_char(sysdate - hst.days_to_keep)) target_oldest,
       max(time_stamp) newest,
       count (*) count
  from history_log_tab hlt,
       history_setting_tab hst
 where hst.table_name = hlt.table_name(+)
 group by hst.table_name, module
 order by hst.table_name, module;
--
PROMPT 
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  List tables that History Logging was once enabled for but is not currently.
-- 
--
--
select distinct table_name from history_log_tab a
 minus
select distinct table_name from history_setting_tab b 
 order by table_name;
--
--
--
break   on report;
compute sum of num_rows on report;
compute sum of blocks   on report;
compute sum of mb_used  on report;
column table_name format a38;
column blocks     format 999,999,999,999;
column count      format 999,999,999,999,999 justify right;
column mb_used    format 9,999,999;
column module     format a10;
column num_rows   format 999,999,999,999;
--
PROMPT 
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Storage usage for history logging
PROMPT
-- 
select table_name, num_rows, blocks,
       blocks * (select value from v$parameter where name = 'db_block_size') / 1024 /1024 mb_used
  from user_tables 
 where table_name in ('HISTORY_LOG_TAB','HISTORY_LOG_ATTRIBUTE_TAB')
 order by table_name, num_rows;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3d
PROMPT
PROMPT       Show the sizes of the tables and the LOB segments used in  
PROMPT       application messaging.
PROMPT
PROMPT       Some queries N/A for 2004 all SPs (no LOBS, no FNDCN_ tables)
PROMPT       
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       
PROMPT       FNDCN_APPLICATION_MESSAGE_TAB
PROMPT       FNDCN_MESSAGE_BODY_TAB
PROMPT       
PROMPT       Cleanup:
PROMPT         There are two default clean up jobs runs as Application Server Tasks 
PROMPT         (IFS EE-> Solution Manager-> Integration-> Schedule Application Server Tasks)
PROMPT            or
PROMPT         (IFS EE-> Solution Manager-> Configuration-> Integration-> Schedule Application Server Tasks)
PROMPT
PROMPT         FNDCN_MESSAGE_BODY_TAB consists of application messages bodies. You can clean them using cleanup 
PROMPT         jobs. There are two default clean up jobs runs as Application Server Tasks 
PROMPT         (IFS EE->Solution Manager->Integration->Schedule Application Server Tasks) to clean up 
PROMPT         notification queue and trashcan queue. If they are not running you can restart them. 
PROMPT         You can create some more tasks to clean up other queues, if required.
PROMPT
PROMPT         There are Application server Tasks set up to clean up application messages 
PROMPT         in state "FINISHED" in BATCH1 queue and also a Application server Tasks 
PROMPT         to clean up the "NOTIFICATIONS" queue. 
PROMPT
PROMPT        (not in all IFS versions)
PROMPT
set echo off;
clear breaks columns computes;
--
column column_name     format a35;
column count           format 99,999,999 justify right;
column create_year     heading 'Create|Year';
column message_type    format a35;
column oldest_create_date heading 'Oldest|Create|Date';
column queue           format a15;
column segment_name    format a35;
column size_in_MB      format 999,999.999;
column size_in_MB_LOBS format 999,999.999;
column state           format a15;
column table_name      format a35;
column tablespace_name format a30;
column Fndcn_application_message_tab format 99,999,999 justify right;
column Fndcn_message_body_tab        format 99,999,999 justify right;
--
break   on report;
compute sum of size_in_MB on report;
compute sum of size_in_MB_LOBS on report;
compute sum of count(*) on report;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT Size of Tables
--
select distinct segment_name,tablespace_name,sum(bytes)/1024/1024 Size_in_MB
  from user_segments
 where segment_name like 'FNDCN%'
 group by segment_name,tablespace_name
 order by segment_name;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT Size of LOBS
--
select distinct l.table_name,s.tablespace_name,l.column_name, 
       sum(bytes)/1024/1024 Size_In_MB_LOBS
  from user_lobs l, user_segments s
 where l.segment_name = s.segment_name
   and l.table_name  like 'FNDCN%'
group by l.table_name,s.tablespace_name,l.column_name
order by 1,2;
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
--  Fails in IFS 2003/2004
--
PROMPT
PROMPT Number of rows
PROMPT Fails in IFS 2003/2004
--
select 'Row Count' Row_Count,
(select count (*) from fndcn_application_message_tab) Fndcn_application_message_tab, 
(select count (*) from fndcn_message_body_tab) Fndcn_message_body_tab
from dual;
-- 
--
break on queue skip 1 on create_year skip 1 on report;
compute sum of count on report;
compute sum of count on create_year;
compute sum of count on queue;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT Age of data in FNDCN_APPLICATION_MESSAGE_TAB 
PROMPT Fails in IFS 2003/2004
--

--old
--select distinct extract(year from created_date) create_year,
--       min(created_date) oldest_create_date,
--       message_type, state, count (*) count
--  from fndcn_application_message_tab 
-- group by extract(year from created_date),message_type,state
-- order by extract(year from created_date),message_type,state;
 
 
select distinct  message_type, state, queue,
       extract(year from created_date) create_year,
       extract(MONTH from created_date) create_month,
       min(created_date) oldest_create_date,
      count (*) count
  from fndcn_application_message_tab 
 group by  message_type, state, queue,extract(year from created_date), extract(MONTH from created_date)
 order by  message_type, state, queue,extract(year from created_date), extract(MONTH from created_date);
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT
PROMPT Age of data in FNDCN_MSG_ARCHIVE_TAB 
PROMPT Fails in IFS 2003/2004
--
select distinct message_type,state,
       extract(year from created_date) create_year,
       extract(MONTH from created_date) create_month,
       min(created_date) oldest_create_date,
       count (*) count
  from fndcn_msg_archive_tab  
 group by message_type, state, extract(year from created_date),extract(MONTH from created_date)
 order by message_type, state, extract(year from created_date),extract(MONTH from created_date);
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Look for orphaned rows in fndcn_message_body_tab
PROMPT  Fails in IFS 2003/2004
PROMPT  
clear breaks;
--
select count (*) count from 
(select application_message_id from fndcn_message_body_tab
 minus
 select application_message_id from fndcn_application_message_tab);
--
--
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Look for orphaned rows in fndcn_application_message_tab
PROMPT  Fails in IFS 2003/2004
PROMPT  
--
select count(*) count
  from fndcn_application_message_tab a
 where not exists 
    (select 1 from fndcn_message_body_tab b
      where a.application_message_id = b.application_message_id);
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       IN_MESSAGE_TAB
PROMPT       OUT_MESSAGE_TAB
PROMPT
PROMPT       Cleanup:  Light Cleanup (Apps 7 -> 8.0 SP1) only for "Accepted" messages
PROMPT       There is no way to change state of the messages in the client.
PROMPT       You need to do the change in the table:
PROMPT       UPDATE in_message_tab SET rowstate = 'Accepted' WHERE receiver = '<name>'
PROMPT           and extract(year from transferred_time) = 2001;
PROMPT       UPDATE out_message_tab SET rowstate = 'Accepted' WHERE receiver = '<name>'
PROMPT         and extract(year from exec_time) = 2001;
PROMPT       commit;
PROMPT
PROMPT       After that the messages should be removed by the light cleanup process.
PROMPT
set echo off;
break   on report;
--
compute sum of size_in_MB on report;
compute sum of size_in_MB_LOBS on report;
compute sum of count(*) on report;
--
column l.column_name  format a35;
column message_status format a25;
column receiver       format a20;
column segment_name   format a35;
--
column parameter      format a25;
column parameter_desc format a65;
column value          format a15;
--
column in_message_tab         format 99,999,999 justify right;
column in_message_line_tab    format 99,999,999 justify right;
column out_message_tab        format 99,999,999 justify right;
column out_message_line_tab   format 99,999,999 justify right;
--
--set echo on;
--
select parameter,parameter_desc, value  
  from fnd_setting 
 where parameter like 'CON%' 
 order by parameter;
--
PROMPT
PROMPT  Row count of messaging tables  
PROMPT  Orphan rows removed during upgrade
PROMPT
select 'Row Count' Row_Count,
(select count (*) count from in_message_tab) in_message_tab, 
(select count (*) count from in_message_line_tab) in_message_line_tab, 
(select count (*) count from out_message_tab) out_message_tab,
(select count (*) count from out_message_line_tab) out_message_line_tab
  from dual;
--
--
--
break on year skip 1 on report;
compute sum of count on report;
compute sum of count on year;
PROMPT
PROMPT  Details for IN_MESSAGE_TAB
PROMPT
select distinct extract(year from transferred_time) year, receiver,
       rowstate Message_Status,        
       count (*) count,
       min(transferred_time)  oldest,
       max(transferred_time)  newest 
  from in_message_tab  
--  where extract(year from transferred_time) = 2001
 group by extract(year from transferred_time), receiver, rowstate
 order by extract(year from transferred_time), receiver, rowstate;
PROMPT
PROMPT  Details for OUT_MESSAGE_TAB
PROMPT  Cleanup:  Light Cleanup (Apps 7 -> 8.0 SP1) only for "Accepted" messages
PROMPT
select distinct extract(year from exec_time) year,
       rowstate Message_Status,
       count (*) count,
       min(exec_time) oldest,
       max(exec_time) newest 
  from out_message_tab  
 group by extract(year from exec_time),rowstate
 order by extract(year from exec_time),rowstate;
--
--
set echo off;
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       Financials EXTERNAL FILES LOAD
PROMPT
PROMPT       Cleanup:  
PROMPT          Apps 7:  Accounting Rules/External Files/Overview External File Transactions
PROMPT
PROMPT          Other    Accounting Rules/External Files/Monitor External Files/External Files Load IDs
PROMPT                   Populate, Select rows, RMB EDIT/DELETE, commit
PROMPT
set echo off;
clear breaks columns computes;
break   on report;
--
column column_name     format a35;
column segment_name    format a35;
column table_name      format a35;
column count           format 99,999,999 justify right;
column state           format a15;
column table_name      format a35;
--
compute sum of count on report;
compute sum of Size_in_MB on report;
compute sum of Size_In_MB_LOBS on report;
--
column Size_in_MB      format 9,999,999.999;
column Size_in_MB_LOBS format 9,999,999.999;
--
PROMPT
PROMPT  Details for EXT_FILE_LOAD_TAB
PROMPT
--
select distinct extract(year from load_date) year,
       state, 
       count (*) count
  from ext_file_load_tab
 group by extract(year from load_date),state
 order by extract(year from load_date),state;
PROMPT
PROMPT  Details for EXT_FILE related tables
PROMPT
select distinct segment_name, tablespace_name, sum(bytes)/1024/1024 Size_in_MB
  from user_segments
 where segment_name like 'EXT_FILE%' 
 group by segment_name,tablespace_name
 order by segment_name;
PROMPT
PROMPT  Details for EXT_FILE related LOBS
PROMPT
select distinct l.table_name, s.tablespace_name, l.column_name, sum(bytes)/1024/1024 Size_In_MB_LOBS
  from user_lobs l, user_segments s
 where l.segment_name = s.segment_name
   and (l.table_name  like 'EXT_FILE%')
 group by l.table_name,s.tablespace_name,l.column_name
 order by 1,2;
--
--
set echo off;
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3e
PROMPT
PROMPT       Show the size and configuration of server_log_tab related objects
PROMPT
PROMPT       N/A for 2004 - tables not found
PROMPT
PROMPT       If the resulting count is high (> 1,000,000 or so) 
PROMPT       IFS needs to investigate this issue further.
PROMPT
PROMPT       Potential for performance problem on 7.5 SP5/SP6. 
PROMPT       See solution 178864 (patches 93274 (in core FNDBAS CPS 8) and 94056), and 94116
PROMPT
PROMPT       ============================================================
PROMPT
--           delete from server_log_tab
--            where extract(year from date_created) = 2019
--              and extract(month from date_created) = 1
--
--
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break on report;
column count format 999,999,999,999;
column category_id format a20;
column checked     format a20;
compute sum of count on report;
--
--  Fails in IFS 2003/2004
--
--
select distinct extract(year from date_created) year,
                extract(month from date_created) month,
                category_id,
                checked,       
       count(*) count, 
       min(date_created) Oldest,
       max(date_created) Newest
  from server_log_tab
 group by extract(year from date_created), extract(month from date_created),category_id,checked
 order by extract(year from date_created), extract(month from date_created),category_id,checked;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Number of segments for SERVER_LOG_TAB
PROMPT  Should get zero rows in IFS 2003/2004
PROMPT
connect &&sys_connect;
show user;
-- 
clear breaks;
--
select count(*) count from dba_segments 
 where segment_name = 'SERVER_LOG_TAB';
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT --------------------------------------------------------------------------------;
PROMPT
PROMPT  Data related to 'Server_Log_Utility_API.Transfer_Audit_Records_'
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column state          format a10;
column procedure_name format a62;
column Time_Interval_Days format 999.9 heading 'Time|Interval|Days'
--
--  N/A for IFS 2003
--
select distinct state,
       procedure_name,
       queue_id,
       count (*) count,
       max (executed) - min (executed) Time_Interval_Days,
       min (executed) oldest, 
       max (executed) newest
  from transaction_sys_local_tab
 where procedure_name = 'Server_Log_Utility_API.Transfer_Audit_Records_'
 group by state,procedure_name,queue_id
 order by state,procedure_name,queue_id;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       Set 3 Data Volume Queries
PROMPT
PROMPT       Query 3f
PROMPT
PROMPT       Show the sites defined
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column contract format a6 heading 'Site';
column delivery_address format a20;
column dist_calendar_id  format a17;
column manuf_calendar_id format a17;
column company format a10;
column rowkey noprint;
--
select c.company, s.*,
 '______________________________________________________________________________________________________________'
  from site_tab s,
       company_tab c
 where c.company = s.company
 order by 1, 2;
--
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4a
PROMPT
PROMPT       List number of reports, 'lifespan', in REPORT_ARCHIVE_TAB by report.
PROMPT
PROMPT       Lifespan determines how long the report will remain before 
PROMPT       being deleted by cleanup routines.
PROMPT
PROMPT       You can define expiration periods for reports.  The number of 
PROMPT       reports you have and their age (shown by the results of query),
PROMPT       may or may not be appropriate for your particular business.  
PROMPT       Customer must review query results and adjust expiration periods 
PROMPT       if they determine that to be necessary.
PROMPT       
PROMPT       You can set life time for each report. Once the report is generated expiration 
PROMPT       date will be calculated using the Life time 
PROMPT
PROMPT         Apps 7.5 and later
PROMPT          1. Select your report (Solution Manager\Configuration\Info Services\Reports ) 
PROMPT          2. Go to the report details 
PROMPT          3. RMB on the Header-> Set Default Life Time 
PROMPT
PROMPT       Reports staying in the database past their LIFE setting may 
PROMPT       be because they are in a WAITING or ERROR status. 
PROMPT       Reports in those status will not get cleared out automatically. (Verified Apps 2004, 7)
PROMPT       You have to manually remove them using Admin Tool/Solution Manager.
PROMPT
PROMPT       Later queries report on potential report cleanup problems 
PROMPT       and may indicate IFS assistance may be required.  However,
PROMPT       report cleanup expiration dates (retention period) should be addressed
PROMPT       before taking action on later queries.  Once all reports have a 
PROMPT       desired retention period, and heavy cleanup has successfully run, 
PROMPT       address other issues found by the later queries.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
set echo off;
--
clear breaks columns computes;
--
break on report;
compute sum of Count on report;
compute sum of rows_in_archive on report;
--
column life_char     format A4  heading 'Days|To|Keep';
column target_date              heading 'Default|Cleanup|Target|Date';
column target_oldest format A12 heading 'Target|Purge|Date';
column oldest_report format A12 heading 'Oldest|Report';
column newest_report format A12 heading 'Newest|Report';
column blank         format A3 heading ' ';
column Count         format 9,999,999 justify right;
column Count_in_Archive_Tab format 9,999,999 heading 'Count of reports|in ARCHIVE_TAB';
--
column report_id       format A30;
column lu_name         format A30;
column module          format A6;
column table_name      format A30;
column layout_name     format A35 heading 'Layout Name';
column report_title    format A50 heading 'Report Title';
column rows_in_archive format 999,999,999 heading 'Rows In|Archive';
column min(a.exec_time) heading 'Earliest|Execution';
--
--
--
Prompt
Prompt
Prompt  Reports in Archive_tab with no entry in report_sys_tab
Prompt  No way to remove these using standard cleanup routines
--
select distinct at.report_id 
  from archive_tab at 
 where not exists (select 1 from report_sys_tab rst where at.report_id = rst.report_id)
 order by at.report_id;
--
--
Prompt
Prompt
Prompt  Entries in report_sys_tab with no TABLE_NAME defined
Prompt  No way to remove these using standard cleanup routines
--
select distinct rst.report_id, report_title, module, lu_name, count (at.result_key) Count_in_Archive_Tab
  from report_sys_tab rst, archive_tab at
 where rst.report_id = at.report_id(+)
   and table_name   is null 
 group by rst.report_id, report_title, module, lu_name
 order by rst.report_id;
--
Prompt
Prompt
Prompt  This query shows default "LIFE" for existing reports unless overridden for specific reports
Prompt
--
select Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS'))  target_date from dual;
--
Prompt
Prompt
Prompt  This query shows defined "LIFE" for existing reports
Prompt
--
select distinct at.report_id, rst.table_name,
       nvl(to_char(rst.life), 'NULL') life_char,
       count(*) count,
       '  ' blank,
       to_char(min(at.exec_time))  oldest_report,
       to_char(sysdate - rst.life) target_oldest,
       to_char(max(at.exec_time))  newest_report
  from archive_tab at, report_sys_tab rst  
 where at.report_id = rst.report_id (+)
 group by at.report_id, rst.table_name,rst.life 
 order by at.report_id;
--
Prompt
Prompt
Prompt  This query shows reports that based on defined 'LIFE'
Prompt  should have been removed
Prompt  (Not accurate if LIFE = 0 or NULL)
Prompt
select distinct at.report_id, rst.table_name,
       nvl(to_char(rst.life), 'NULL') life_char,
       count(*) count,
       '  ' blank,
       to_char(min(at.exec_time))  oldest_report,
       to_char(sysdate - rst.life) target_oldest,
       to_char(max(at.exec_time))  newest_report
  from archive_tab at,report_sys_tab rst  
 where at.report_id = rst.report_id (+)
   and at.exec_time < (sysdate - rst.life)
 group by at.report_id,rst.table_name,rst.life 
 order by at.report_id;
--
Prompt
Prompt
Prompt Determine number of reports in Archive because they are found in Print_job tables,
Prompt past their expire_date, and they are in a WAITING or ERROR status.
Prompt
Prompt Upgrade cleanup scripts should clear out these reports
Prompt
Prompt Validated for:  Apps 2004 SP3
Prompt 
--
column count format 9,999,999 justify right heading 'Count';
column min_arrive heading 'Minimum|Arrive';
column min_expire heading 'Minimum|Expire';
--
select distinct at.report_id,count(*) count,
       min(arrival_time) min_arrive,
       min(expire_date)  min_expire
  from archive_distribution_tab a,
       archive_tab at
 where exists
     (select 1 from print_job_contents_tab b
          where b.result_key = a.result_key
          and exists
              (select 1 from print_job_tab c
                where c.print_job_id = b.print_job_id
                  and c.status in ('WAITING', 'ERROR')
                  and c.expire_date < sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS'))))
   and a.result_key = at.result_key
 group by at.report_id
 order by at.report_id;
--
Prompt
Prompt
Prompt  Determine number of reports in Archive because they are found in Print_job tables,
Prompt  past their expire_date, and they ARE NOT in a WAITING or ERROR status.
Prompt 
Prompt  Upgrade cleanup scripts should clear out these reports
Prompt
Prompt  Validated for:  Apps 2004 SP3
Prompt
--
column count format 9,999,999 justify right heading 'Count';
column min_arrive heading 'Minimum|Arrive';
column min_expire heading 'Minimum|Expire';
--
select distinct at.report_id,count(*) count,
       min(arrival_time) min_arrive,
       min(expire_date)  min_expire
  from archive_distribution_tab a,
       archive_tab at
 where exists
     (select 1 from print_job_contents_tab b
          where b.result_key = a.result_key
          and exists
              (select 1 from print_job_tab c
                where c.print_job_id = b.print_job_id
                  and c.status not in ('WAITING', 'ERROR')
                  and c.expire_date < sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS'))))
   and a.result_key = at.result_key
 group by at.report_id
 order by at.report_id;
--
Prompt
Prompt
Prompt  This query shows reports that are older than defined "life" 
Prompt  OR
Prompt  there is no entry in report_sys_tab for the entry in archive_tab
Prompt
Prompt  NOT SURE THIS QUERY IS ACCURATE DUE TO HOW "LIFE" IS CALCULATED
Prompt
--
select distinct at.report_id, rst.table_name, rst.life,
       count(*) count, '  ' blank,
       to_char(min(at.exec_time))  oldest_report,
       to_char(sysdate - rst.life) target_oldest,
       to_char(max(at.exec_time))  newest_report
  from archive_tab at,report_sys_tab rst  
 where at.report_id = rst.report_id (+)
   and rst.life > 0 and rst.life is not null
   and to_date(at.exec_time) <  to_date(sysdate - rst.life)
 group by at.report_id, rst.table_name, rst.life 
 order by at.report_id;
--
Prompt
Prompt
Prompt Show number of rows by report name
Prompt Review for potentially adjusting "life" of a report
Prompt
--
--
select a.report_id, b.report_title, a.layout_name, 
       min(a.exec_time), count(*) rows_in_archive
  from archive_tab a, 
       report_sys_tab b
 where a.report_id = b.report_id
-- and a.report_id in ( 'SHOP_ORD_WIO_REP', 'LAS_PURCHASE_RECEIPT_REP','LONG_TERM_CUST_INV_DUE_REP', 'LAS_PURCHASE_RECEIPT_NI_REP')
 group by a.report_id, a.layout_name, b.report_title
 order by report_id;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4b
PROMPT
PROMPT       List number of reports, oldest of each report, in PDF_ARCHIVE_TAB by report.
PROMPT
PROMPT       Based on results, you may want to review retention periods for reports.
PROMPT
PROMPT       Once the issues reported by this query have been addressed, 
PROMPT       work to address other issues found by the later queries can begin.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break on report;
column size_in_mb format 9,999,999.9;
compute sum of count on report;
compute sum of size_in_mb on report;
--
column Count       format 99,999,999 justify right;
column layout_name format a50 heading 'Layout Name';
--
Prompt
Prompt
Prompt  List number of reports, oldest of each report, in PDF_ARCHIVE_TAB by report.
Prompt  Fails for IFS 2003
Prompt
select a.*   
  from (select distinct layout_name, count (*) count,
              ceil(sum(pdf_size) / 1024 / 1024) size_in_mb, 
              min (rowversion) oldest,
              max (rowversion) newest
         from pdf_archive_tab 
        group by layout_name 
        order by layout_name ) a;
--
PROMPT
PROMPT       ============================================================
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4c
PROMPT       Print Job Cleanup status
PROMPT
PROMPT       Determine number of reports that remain in the database  
PROMPT       past their expire_date and are eligible for cleanup
PROMPT       (Status = 'COMPLETE' or 'INACTIVE')
PROMPT
PROMPT       If the query "Print Jobs eligible for cleanup but still exist"
PROMPT       returns any row count above zero, IFS needs
PROMPT       to investigate this issue further, assuming above cleanup tasks
PROMPT       have been addressed by customer/system administrator
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
--
break on report;
compute sum of count on report;
--
column count format 9,999,999 justify right heading 'Count';
column rpt_expire  heading 'Earliest|Rpt Exp|Date';
column target_date heading 'Cleanup|Target|Date';
column status  format a30;
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Print Jobs eligible for cleanup but still exist
PROMPT
select distinct status, count (*) count,  min(expire_date) rpt_expire,
       sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS')) target_date
  from print_job_tab c
 where c.status in ('COMPLETE', 'INACTIVE')
   and c.expire_date < sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS'))
 group by status
 order by status;
--
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  All Print Jobs by status, from print_job_tab
PROMPT
select distinct status, count (*) count,  min(expire_date) rpt_expire,
       sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS')) target_date
  from print_job_tab c
 group by status
 order by status;
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Count by year of print_job_tab
PROMPT
PROMPT  EXAMPLE:  delete from print_job_tab where  extract(year from rowversion)  = 2013;
PROMPT
select distinct extract(year from expire_date) year,
       count (*) count
  from print_job_tab
 group by extract(year from expire_date)
 order by extract(year from expire_date);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Count by year of print_job_contents_tab
PROMPT
PROMPT  EXAMPLE:  delete from print_job_contents_tab where  extract(year from rowversion)  = 2013;
PROMPT
select distinct extract(year from rowversion) year,
       count (*) count
  from print_job_contents_tab
 group by extract(year from rowversion)
 order by extract(year from rowversion);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Orphaned rows print_job_tab - print_job_contents_tab
PROMPT
PROMPT  After print_job_tab is cleaned, should be no orphans in 
PROMPT  print_job_contents_tab
PROMPT
--
clear breaks;
select count(*) count 
  from print_job_contents_tab a
 where not exists
     (select 1 from print_job_tab b
       where b.print_job_id = a.print_job_id);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Orphaned rows print_job_tab - print_queue_tab
PROMPT
select count(*) count 
  from print_queue_tab a
 where not exists
     (select 1 from print_job_tab b
       where b.print_job_id = a.print_job_id);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Orphaned rows print_job_contents_tab - archive_tab
PROMPT
select count(*) count 
  from print_job_contents_tab a
 where not exists
     (select 1 from archive_tab b
       where a.result_key = b.result_key);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Rows in archive_distribution_tab related to expired reports not being removed
PROMPT
--
--
select count(*) count from archive_distribution_tab a
 where exists
  (select 1 from print_job_contents_tab b
    where b.result_key = a.result_key
      and exists
     (select 1 from print_job_tab c
       where c.print_job_id = b.print_job_id
         and c.status in ('COMPLETE', 'INACTIVE')
         and c.expire_date < sysdate - Client_SYS.Attr_Value_To_Number(Fnd_Setting_API.Get_Value('KEEP_PRINTJOBS'))));
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT       ============================================================
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4d
PROMPT
PROMPT       Check for orphaned reports related data
PROMPT
PROMPT       If the query returns any row count above zero, IFS needs
PROMPT       to investigate this issue further, assuming above cleanup tasks
PROMPT       have been addressed by customer/system administrator.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
-- 
--  Check for orphaned archived reports contents
--
--  If the query returns any row count above zero, then IFS needs
--  to investigate this issue further, assuming above cleanup tasks
--  have been addressed by customer/system administrator
--
--  (For Report_ID LONG_TERM_CUST_INV_DUE_REP  see patch 106850, not in core as of 8.0 SP1+)
--  (For Report_ID INVENTORY_PART_SHORTAGE_REP see patch 72169, in core 7.5 SP2)
--  (For Report_ID SHOP_ORD_WI_BAR_REP         see patch 88756, in core 7.5 SP6)
--
set echo off;
column count         format 999,999,999 justify right heading 'Count';
column layout_name   format a45;
column oldest_report format A12 heading '    Oldest     ';
column newest_report format A12 heading '  Newest';
column blank         format A3 heading '   ';
column blank2        format A3 heading '   ';
column report_id     format A30;
column layout_name   format A35;
--
break   on report;
compute sum of count on report;
--
select distinct report_id, layout_name, count(*) count, '   ' blank,
       min(exec_time) oldest_report, '   ' blank2,
       max(exec_time) newest_report
  from archive_tab  a
 where not exists
    (select 1 from archive_distribution_tab b
      where b.result_key = a.result_key)
 group by report_id,layout_name
 order by report_id;
--
clear breaks;
set feedback off;
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_TAB
PROMPT
select count (*) count 
  from archive_tab a
 where not exists
      (select 1 from archive_distribution_tab b
        where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_DISTRIBUTION_TAB
PROMPT
select count(*) count 
  from archive_distribution_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in PRINT_QUEUE_TAB
PROMPT
select count(*) count 
  from print_queue_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.print_job_id);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in PRINT_JOB_CONTENTS_TAB
PROMPT
select count(*) count
  from print_job_contents_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.print_job_id);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_PARAMETER_TAB
PROMPT
select count (*) count 
  from archive_parameter_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_PARAMETER_TAB
PROMPT
select count (*) count 
  from archive_parameter_tab a
 where not exists
     (select 1 from archive_distribution_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_VARIABLE_TAB
PROMPT
select count (*) count 
  from archive_variable_tab a
 where not exists
     (select 1 from archive_distribution_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in XML_REPORT_DATA_TAB
PROMPT
select count (*) count 
  from xml_report_data_tab a
 where not exists
     (select 1 from archive_distribution_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_FILE_NAME_TAB
PROMPT
select count (*) count 
  from archive_file_name_tab a
 where not exists
     (select 1 from archive_distribution_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in PDF_ARCHIVE_TAB
PROMPT
select count (*) count 
  from pdf_archive_tab a
 where not exists
     (select 1 from archive_distribution_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_VARIABLE_TAB
PROMPT
select count (*) count 
  from archive_variable_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in XML_REPORT_DATA_TAB
PROMPT
select count (*) count 
  from xml_report_data_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in ARCHIVE_FILE_NAME_TAB
PROMPT
select count (*) count 
  from archive_file_name_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in PDF_ARCHIVE_TAB
PROMPT
select count (*) count 
  from pdf_archive_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count orphan rows in EXCEL_REPORT_ARCHIVE_TAB
PROMPT
select count (*) count 
  from excel_report_archive_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.result_key
         and b.report_id  = a.report_id);
--
--
--
--------------------------------------------------------------------------------
--  Query orphaned rows in reports tables
--  Report table exists but no entry in report_sys_tab
--
--  See G1220582-A
--
--------------------------------------------------------------------------------
set serveroutput on size 1000000;
set echo off;
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Query - Orphan rows in reports data hold tables
PROMPT
declare
  cursor c is
  SELECT DISTINCT a.table_name
    FROM user_tables a,
         user_tab_cols utc
   WHERE a.table_name like '%_RPT'  
     AND a.table_name = utc.table_name 
     AND utc.column_name = 'RESULT_KEY'
    and  not exists (select 1 from report_sys_tab  b WHERE a.table_name = b.table_name)
   order by table_name;

   rows_ NUMBER := 0;
   stmt_ VARCHAR2(2000);
BEGIN
   FOR x IN c LOOP
     -- dbms_output.put_line('Table name ' || x.table_name);
      IF Database_SYS.Table_Exist(x.table_name) THEN
          rows_ := 0;
          stmt_ := 'BEGIN ' || 'SELECT count(*) INTO :rows FROM ' || x.table_name ||
                   ' a WHERE not exists (select 1 from archive_tab b WHERE a.result_key = b.result_key)' || '  ; END; ' ;
          EXECUTE IMMEDIATE stmt_ USING IN OUT rows_; 
          IF rows_ > 0 THEN
              dbms_output.put_line('****  ARCHIVE_TAB:  Orphaned rows exist for Table name ' || x.table_name || '  ' || rows_);
              dbms_output.put_line('  ');
          END IF;  
      ELSE
          dbms_output.put_line('****Error Cannot find Table name ' || x.table_name);   
      END IF;
   END LOOP;
END;
/ 
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Report table exists in report_sys_tab
PROMPT
declare
   cursor c is
   select distinct table_name
     from report_sys_tab     
    where table_name like '%_RPT'
    order by 1;

   rows_ NUMBER := 0;
   stmt_ VARCHAR2(2000);
BEGIN
   FOR x IN c LOOP
     -- dbms_output.put_line('Table name ' || x.table_name);
      IF Database_SYS.Table_Exist(x.table_name) THEN
          rows_ := 0;
          stmt_ := 'BEGIN ' || 'SELECT count(*) INTO :rows FROM ' || x.table_name ||
                   ' a WHERE not exists (select 1 from archive_tab b WHERE a.result_key = b.result_key)' || '  ; END; ' ;
          EXECUTE IMMEDIATE stmt_ USING IN OUT rows_; 
          IF rows_ > 0 THEN
              dbms_output.put_line('****  ARCHIVE_TAB:  Orphaned rows exist for Table name ' || x.table_name || '  ' || rows_);
              dbms_output.put_line('  ');
          END IF;  
      ELSE
          dbms_output.put_line('****Error Cannot find Table name ' || x.table_name);   
      END IF;
   END LOOP;
END;
/ 
PROMPT
PROMPT
--
declare
   cursor c is
  SELECT DISTINCT a.table_name
    FROM user_tables a,
         user_tab_cols utc
   WHERE a.table_name like '%_RPT'  
     AND a.table_name = utc.table_name 
     AND utc.column_name = 'RESULT_KEY'
     and  not exists (select 1 from report_sys_tab  b WHERE a.table_name = b.table_name)
    order by table_name;

   rows_ NUMBER := 0;
   stmt_ VARCHAR2(2000);
BEGIN
   FOR x IN c LOOP
     -- dbms_output.put_line('Table name ' || x.table_name);
      IF Database_SYS.Table_Exist(x.table_name) THEN
          rows_ := 0;
          stmt_ := 'BEGIN ' || 'SELECT count(*) INTO :rows FROM ' || x.table_name ||
                   ' a WHERE not exists (select 1 from archive_distribution_tab b WHERE a.result_key = b.result_key)' || '  ; END; ' ;
          EXECUTE IMMEDIATE stmt_ USING IN OUT rows_; 
          IF rows_ > 0 THEN
              dbms_output.put_line('****  ARCHIVE_DISTRIBUTION_TAB:  Orphaned rows exist for Table name ' || x.table_name || '  ' || rows_);
              dbms_output.put_line('  ');
          END IF;  
      ELSE
          dbms_output.put_line('****Error Cannot find Table name ' || x.table_name);   
      END IF;
   END LOOP;
END;
/ 
PROMPT
PROMPT
--
DECLARE
   cursor c is
   select distinct table_name
      from report_sys_tab
     where table_name like '%_RPT'
     order by 1;

   rows_ NUMBER := 0;
   stmt_ VARCHAR2(2000);
BEGIN
   FOR x IN c LOOP
     -- dbms_output.put_line('Table name ' || x.table_name);
      IF Database_SYS.Table_Exist(x.table_name) THEN
          rows_ := 0;
          stmt_ := 'BEGIN ' || 'SELECT count(*) INTO :rows FROM ' || x.table_name ||
                   ' a WHERE not exists (select 1 from archive_distribution_tab b WHERE a.result_key = b.result_key)' || '  ; END; ' ;
          EXECUTE IMMEDIATE stmt_ USING IN OUT rows_; 
          IF rows_ > 0 THEN
              dbms_output.put_line('****  ARCHIVE_DISTRIBUTION_TAB:  Orphaned rows exist for Table name ' || x.table_name || '  ' || rows_);
              dbms_output.put_line('  ');
          END IF;
      ELSE
         dbms_output.put_line('****Error Cannot find Table name ' || x.table_name);
      END IF;
   END LOOP;
END;
/
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
set feedback on;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4e
PROMPT
PROMPT       Check for issue with Financial Report Writer data cleanup
PROMPT       A very large number (> 1,000,000 or so) may indicate a 
PROMPT       failure of heavy cleanup job and/or the need for patch 61251.
PROMPT
PROMPT       61251 was in core product as of IFS Applications 7 SP3.
PROMPT
PROMPT       ============================================================
PROMPT
-- 
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column Count format 999,999,999,999;
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Count rows in RESULT_CELL_TAB
PROMPT
select count(*) count from result_cell_tab;
--
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4f
PROMPT
PROMPT       Show size of the reports data tables
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break   on report;
column size_in_KB       format 9,999,999,999;
col segment_name format a30;
column tablespace_name  format a30;
compute sum of Size_in_KB on report;
PROMPT
PROMPT
PROMPT  Data storage for segments named *_RPT
PROMPT
select distinct segment_name, tablespace_name, 
       ceil(sum(bytes)/1024) Size_in_KB
  from user_segments
 where segment_name like '%_RPT' 
   and segment_type = 'TABLE'
  and  segment_name not in ('TMP_CUST_PAY_JOUR_RPT','TMP_SUPP_PAY_JOUR_RPT')
 group by segment_name, tablespace_name
 order by segment_name, tablespace_name;
PROMPT
PROMPT
PROMPT  Data storage for segments named *_TAB
PROMPT
select distinct segment_name, tablespace_name, 
       ceil(sum(bytes)/1024) Size_in_KB
  from user_segments
 where segment_name in 
       ('ARCHIVE_DISTRIBUTION_TAB',
        'ARCHIVE_TAB',
        'PRINT_JOB_TAB',
        'PRINT_JOB_CONTENTS_TAB',
        'PRINT_QUEUE_TAB',
        'REPORT_SYS_TAB') 
 group by segment_name, tablespace_name
 order by segment_name, tablespace_name;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 4 - Reports and Printing
PROMPT
PROMPT       Query 4g
PROMPT
PROMPT       Printing setup 
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
set echo off;
--
clear breaks columns computes;
--
column count                format 999,999 justify right heading 'Count';
column oldest_report        format A12 heading ' Oldest';
column newest_report        format A12 heading ' Newest';
column default_printer      format a10 heading "Default|Printer";
column language_code        format a6  heading "Lang|Code";
column layout_type_owner    format a10 heading "Layout|Type|Owner";
column name                 format a40;
column logical_printer      format a30;
column remote_printing_node format a30;
column rowkey noprint;
--
set echo on;
--
select distinct status, count(*) count, 
       to_char(min(create_time ))  oldest_report,
       to_char(max(create_time ))  newest_report
  from print_queue_tab 
 group by status 
 order by status;
--
--
--
select distinct status, count(*) count, 
       to_char(min(create_time ))  oldest_report,
       to_char(max(create_time ))  newest_report
  from print_queue_tab a
 where not exists
     (select 1 from archive_tab b
       where b.result_key = a.print_job_id)
 group by status 
 order by status;
--
--
--
--  Fails for IFS 2003/2004
--
select * from remote_printer_mapping_tab 
 order by 1,2;
--
--
--
--  Fails for IFS 2003/2004
--
select * from remote_printing_node_tab order by 1;
--
--
--
select * from report_printer_tab order by 1, 2;
--
--
--
select * from report_user_printer_tab order by 1, 2, 3;
--
--
--
--  Fails for IFS 2003
--
select * from report_layout_type_config_tab;
--
--
--
-- select * from report_schema_tab order by 1;
--
--
--
--  Fails for IFS 2003/2004
--
select * from report_font_definition_tab order by 1;
--
--
--
--  Of interest only if running Apps 8
--
select t.*,
 '________________________________________________________________________________________________________________'
 from  report_sys_layout_tab t,
       module_tab
 where in_use = 'TRUE'
   and module = 'FNDBAS' 
   and version like '5%'
   and upper (layout_name) not like '%.RDL%' order by 1, 2;
--
--
set echo off;
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5a
PROMPT
PROMPT       Check for orphaned shop order cost records.
PROMPT       
PROMPT       If upgrading, this data discrepancy is fixed during upgrade 
PROMPT       pre-drop scripts and no action is needed on old version.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
set feedback off;
--
clear breaks columns computes;
--
column count format 999,999,999,999;
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_order_cost_bucket_tab
PROMPT
select count(*) count
  from shop_order_cost_bucket_tab a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no = a.order_no
           and b.release_no = a.release_no
           and b.sequence_no = a.sequence_no);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_order_costed_op_tab
PROMPT
select count(*) count
  from shop_order_costed_op_tab a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no = a.order_no
           and b.release_no = a.release_no
           and b.sequence_no = a.sequence_no);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5b
PROMPT
PROMPT       Check for orphaned records related to shop orders.
PROMPT       
PROMPT       If the query returns any row count above zero, 
PROMPT       IFS needs to investigate these issue further.
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_material_alloc_tab
PROMPT Orphans deleted during upgrade process
PROMPT
select count(*) count
  from shop_material_alloc_tab a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no    = a.order_no
           and b.release_no  = a.release_no
           and b.sequence_no = a.sequence_no);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_ord_lot_batch_no_tab
PROMPT Orphans deleted during upgrade process
PROMPT
select count(*) count
  from shop_ord_lot_batch_no_tab a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no = a.order_no
           and b.release_no = a.release_no
           and b.sequence_no = a.sequence_no);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_material_pick_line_tab
PROMPT Orphans deleted during upgrade process
PROMPT
select count(*) count
  from shop_material_pick_line_tab a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no = a.order_no
           and b.release_no = a.release_no
           and b.sequence_no = a.sequence_no);
--
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT Check for orphans in shop_order_oper_guide_tab
PROMPT Orphans deleted during upgrade process
PROMPT
select count(*) count
  from shop_order_oper_guide_tab  a
 where not exists
       (select 1 
          from shop_ord_tab b
         where b.order_no = a.order_no
           and b.release_no = a.release_no
           and b.sequence_no = a.sequence_no);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5c
PROMPT
PROMPT       Check for shop orders for configured parts with zero costs
PROMPT       
PROMPT       If the query returns any row count above zero, 
PROMPT       IFS needs to investigate these issue further.
PROMPT       More details about the configured cost issue can be found in G1337481.
PROMPT
PROMPT       ============================================================
set echo off;
clear breaks columns computes;
--
column count format 999,999,999,999;
PROMPT
PROMPT  Fails for IFS 2003
PROMPT
--
select count (*) count 
  from shop_ord_tab a
 where configuration_id != '*'
   and rowstate in ('Planned', 'Released', 'Started', 'First Part', 'Parked', 'Reserved')
   and exists
   (select * from inventory_part_config_tab b
     where b.contract = a.contract
       and b.part_no = a.part_no
       and b.configuration_id = a.configuration_id)
       and not exists
--bad records
      (select 1 from inventory_part_unit_cost_tab b
        where b.contract = a.contract
          and b.part_no = a.part_no
          and b.inventory_value > 0
          and b.configuration_id = a.configuration_id)
          and exists
         (select 1 from part_cost_tab b
           where b.contract = a.contract
             and b.part_no = a.part_no
             and b.total_accum_cost > 0
             and b.cost_set = 1)
         and exists
        (select 1 from inventory_part_tab b
          where b.contract = a.contract
            and b.part_no = a.part_no
            and inventory_part_cost_level = 'COST PER CONFIGURATION');
PROMPT
PROMPT
PROMPT
select count (*) count 
  from shop_ord_tab a
 where configuration_id != '*'
   and rowstate in ('Closed')
   and exists
  (select * from inventory_part_config_tab b
    where b.contract = a.contract
      and b.part_no = a.part_no
      and b.configuration_id = a.configuration_id)
      and not exists
--bad records
     (select 1 from inventory_part_unit_cost_tab b
       where b.contract = a.contract
         and b.part_no = a.part_no
         and b.inventory_value > 0
         and b.configuration_id = a.configuration_id)
     and exists
    (select 1 from part_cost_tab b
      where b.contract = a.contract
        and b.part_no = a.part_no
        and b.total_accum_cost > 0
        and b.cost_set = 1)
     and exists
    (select 1 from inventory_part_tab b
      where b.contract = a.contract
        and b.part_no = a.part_no
        and inventory_part_cost_level = 'COST PER CONFIGURATION');
PROMPT
PROMPT
PROMPT
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5d
PROMPT
PROMPT       Check for DOP order close inconsistencies.
PROMPT       
PROMPT       If the query returns any row count above zero, 
PROMPT       IFS needs to investigate this issue further.
PROMPT
PROMPT       revised 5-2-13 for 'Removed'
PROMPT
PROMPT       ============================================================
PROMPT
select count(*)  count 
  from dop_head_tab a 
 where rowstate = 'Closed' 
   and exists 
      (select 1 from dop_order_tab b 
        where b.dop_id = a.dop_id 
          and b.rowstate not in ('Closed', 'Removed') );
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5g
PROMPT
PROMPT       Foundation related 
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Check for orphaned rows related to background jobs
PROMPT
PROMPT       For version 2004 SP5 or earlier
PROMPT
PROMPT       The cleanup of background jobs removes records in 
PROMPT       transaction_sys_local_tab but does not remove 
PROMPT       corresponding records in transaction_sys_status_tab. 
PROMPT
PROMPT       2004 SP5 or earlier:  see patches 34990, 48401, 43346 
PROMPT
PROMPT       If upgrading, this data discrepancy is fixed during upgrade pre-drop scripts
PROMPT       and no action is needed on old version.
--
set timing off;
--
select count(*) count 
  from transaction_sys_status_tab a
 where not exists
      (select 1 from transaction_sys_local_tab b
        where b.id = a.id);
--
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Check status of indexes for language_sys_tab
PROMPT
PROMPT  LANGUAGE_SYS_PK should be found and "valid"
PROMPT
--  See G1184908-Index Unusable IFSAPP.LANGUAGE_SYS_PK
--  
column table_name format a35;
column index_name format a35;
--
select table_name, index_name, status
  from user_indexes 
 where table_name = 'LANGUAGE_SYS_TAB'
 order by index_name; 
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Check for duplicate keys in language_sys_tab
PROMPT
--  Look for data integrity issues in langage_sys_tab due to oracle bug 
--  in (10.2.0.1) that allowed duplicate primary keys.
--
--  Fails for IFS 2003/2004
--
select count (*) count from
  (select distinct main_type, path, attribute,lang_code, count(*) 
     from language_sys_tab 
    group by main_type, path ,attribute,lang_code 
   having count (*) > 1);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Check for duplicate keys in security_sys_privs_tab
PROMPT
--  Determine if duplicate key values exist in security_sys_privs_tab 
--  in violation of security_sys_privs_pk
--
--
select distinct table_name, grantee, privilege, count(*) 
  from security_sys_privs_tab 
 group by table_name,grantee,privilege 
having count (*) > 1
 order by table_name,grantee,privilege;
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Check for duplicate keys in credit_collection_message_tab
PROMPT
--  Determine if duplicate key values exist in credit_collection_message_tab 
--  If following count > 0, duplicate rows exist and PK failed
select count (*) from
(select distinct company,message_no, count (*) 
from credit_collection_message_tab 
having count (*) > 1
group by company,message_no
order by company,message_no);
PROMPT
PROMPT --------------------------------------------------------------------------;
PROMPT
PROMPT  Look for orphaned rows related to in_message_tab, out_message_tab
PROMPT
PROMPT
PROMPT  Parent rows without child - not an issue
PROMPT
select count (message_id) count
  from (select message_id from out_message_tab 
  minus select message_id from out_message_line_tab);
--
select count (message_id) count
  from (select message_id from in_message_tab 
  minus select message_id from in_message_line_tab);
--
PROMPT
PROMPT  Child rows without parent - orphans removed during upgrade
PROMPT
select count (message_id) count
  from (select message_id from out_message_line_tab 
  minus select message_id from out_message_tab);
--
--
select count (message_id) count
  from (select message_id from in_message_line_tab 
  minus select message_id from in_message_tab);
--
PROMPT
PROMPT  Look for Custom Field / IAL default tablespace names that refer
PROMPT  to a tablespace that does not exist
PROMPT
--
column parameter_desc format a35;
column value format a25;
--
select parameter, parameter_desc, value 
 from fnd_setting_tab
where value not in (select tablespace_name from dba_tablespaces)
 and (parameter like 'CF_TS_%'
   or parameter like 'IAL_TABLESPACE%')
order by parameter;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5h
PROMPT
PROMPT       Check for potential issues with transfer of maintenance transactions 
PROMPT       to the GL
PROMPT
PROMPT       For version XXXXX
PROMPT
PROMPT       If either query returns any row count above zero, 
PROMPT       IFS needs to investigate this issue further.
PROMPT
PROMPT       See IFS Solution 187691
PROMPT
PROMPT       ============================================================
PROMPT
select count(*) count 
  from work_order_coding_tab c
 where c.plan_line_no is not null
   and c.cost_type = 'P'
   and 1 not in (select 1
                    from work_order_planning_tab p
                   where p.wo_no = c.wo_no
                     and p.plan_line_no = c.plan_line_no);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5i
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5k
PROMPT
PROMPT       Purchasing related 
PROMPT
PROMPT       ============================================================
PROMPT       
PROMPT         If these queries return any row count above zero,
PROMPT         this may need further investigation.
PROMPT       
PROMPT         RMA material lines without RMA header
PROMPT       
select rma_no, rma_line_no
  from return_material_line_tab a
 where not exists
       (select 1 
          from return_material_tab b
         where a.rma_no = b.rma_no)
 order by 1,2;
PROMPT
PROMPT       ============================================================
PROMPT        
PROMPT         RMA charges without RMA header
PROMPT       
select rma_no,rma_charge_no
  from return_material_charge_tab a
 where not exists
       (select 1 
          from return_material_tab b
         where a.rma_no = b.rma_no)
 order by 1,2;
PROMPT
PROMPT       ============================================================
PROMPT          
PROMPT        Check for data inconsistencies with shop_order_tab table and qty_on_order column.
PROMPT        If following query returns any row counts for any "rowstate", see G1360350
PROMPT        
PROMPT        If upgrading, POST_SHPORD_App75_UpdateQtyOnOrder.sql will need to be run
PROMPT        during pre-upgrade drop scripts
   
select count (*) count 
  from shop_ord_tab 
 where customer_order_no = order_no
   and customer_line_no  = release_no
   and customer_rel_no   = sequence_no
   and demand_code = 'CT'
   and qty_on_order > 0
   and rowstate = 'Closed'
   and qty_on_order > abs(revised_qty_due - qty_complete);
PROMPT
PROMPT       ============================================================
PROMPT    
PROMPT        Multiple Queries related to Price Agreements
PROMPT        IGNORE for customers running Apps 8 or later
PROMPT
PROMPT         Check for potential issues with order/1400.upg (G1337353)
PROMPT       
PROMPT         Below shows AGREEMENT_SALES_PART_DEAL_TAB rows that do not 
PROMPT         have a parent entry in CUSTOMER_AGREEMENT_TAB  
PROMPT       
PROMPT         Dropped during pre-upgrade drop scripts to prevent error in order/1400
PROMPT       
PROMPT         Ignore for upgrades from Apps 8 to later versions
PROMPT       
select count(*) count 
  from agreement_sales_part_deal_tab aspd 
 where not exists (select 1 from customer_agreement_tab cat 
                           where cat.agreement_id = aspd.agreement_id
                             and cat.contract     = aspd.contract);
PROMPT
PROMPT       ============================================================
PROMPT    
PROMPT         Below shows AGREEMENT_SALES_PART_HIST_TAB rows that do not 
PROMPT         have a corresponding entry in AGREEMENT_SALES_PART_DEAL_TAB
PROMPT       
PROMPT         Dropped during pre-upgrade drop scripts to prevent error in order/1400
PROMPT       
PROMPT         Ignore for upgrades from Apps 8 to later versions
PROMPT 
--
select count(*) count  
  from agreement_sales_part_hist_tab asph 
 where not exists (select 1 from agreement_sales_part_deal_tab aspd 
                           where aspd.agreement_id = asph.agreement_id
                             and aspd.catalog_no   = asph.catalog_no
                             and aspd.contract     = asph.contract);
--
PROMPT
PROMPT       ============================================================
PROMPT           
PROMPT         Count AGREEMENT_SALES_PART_DEAL_TAB rows whose contract 
PROMPT         does not match the contract of the CUSTOMER_AGREEMENT_TAB row, 
PROMPT         joined by agreemeent_id.
PROMPT       
PROMPT         Any records found will prevent new index from being able to be created
PROMPT         during upgrade to 8.0.
PROMPT       
PROMPT         Dropped during pre-upgrade drop scripts
PROMPT       
PROMPT         Ignore for upgrades from Apps 8 to later versions
PROMPT       
select count (*) count
 from agreement_sales_part_deal_tab aspd1
where (aspd1.agreement_id, aspd1.contract) in 
(select aspd.agreement_id, aspd.contract
   from agreement_sales_part_deal_tab aspd,
        customer_agreement_tab cat 
  where cat.agreement_id = aspd.agreement_id
    and cat.contract    ^= aspd.contract);
PROMPT
PROMPT       ============================================================
PROMPT           
PROMPT         Count AGREEMENT_SALES_PART_HIST_TAB rows whose contract 
PROMPT         does not match the contract of the CUSTOMER_AGREEMENT_TAB row, 
PROMPT         joined by agreemeent_id.
PROMPT       
PROMPT         Any records found will prevent new index from being able to be created
PROMPT         during upgrade to 8.0.
PROMPT       
PROMPT         Dropped during pre-upgrade drop scripts
PROMPT       
PROMPT         Ignore for upgrades from Apps 8 to later versions
PROMPT      
select count (*) count
  from agreement_sales_part_hist_tab asph1
 where (asph1.agreement_id, asph1.contract) in 
(select asph.agreement_id, asph.contract
   from agreement_sales_part_hist_tab asph, 
        customer_agreement_tab cat 
  where cat.agreement_id = asph.agreement_id
    and cat.contract    ^= asph.contract);
PROMPT
PROMPT       ============================================================
PROMPT     
PROMPT         Check for orphaned records related to purchase orders.
PROMPT         
PROMPT         If these queries return row counts above zero, 
PROMPT         IFS needs to investigate this issue further.
PROMPT       
PROMPT         Check for Missing Delivery Addresses For Open Purchase Orders
PROMPT       
select count(distinct delivery_address) count
  from purchase_order_tab a
 where rowstate in ('Released', 'Received', 'Planned', 'Arrived', 'Confirmed')
   and not exists
       (select 1 
          from company_address_tab b
         where b.company = site_api.get_company(a.contract)
           and b.address_id = delivery_address);
PROMPT
PROMPT       ============================================================
PROMPT       
PROMPT         Check for Missing Document Addresses For Open Purchase Orders
PROMPT         For old version 2004 SP4 or later.
PROMPT       
PROMPT         
select count(distinct document_address_id) count
  from purchase_order_tab a
 where rowstate in ('Released', 'Received', 'Planned', 'Arrived', 'Confirmed')
   and not exists
       (select 1 
          from company_address_tab b
         where b.company = site_api.get_company(a.contract)
           and b.address_id = document_address_id);
PROMPT
PROMPT       ============================================================
PROMPT       
PROMPT         Check for orphans in purch_req_approval_tab
PROMPT         For old version 2004 SP4 or later.
PROMPT  
select count (*) count
  from purch_req_approval_tab p
 where p.requisition_no not in 
       (select pr.requisition_no 
          from purchase_requisition_tab pr
         where pr.requisition_no = p.requisition_no);
PROMPT
PROMPT       ============================================================
PROMPT       
PROMPT         Check for orphans in purch_req_line_approval_tab
PROMPT         For old version 2004 SP4 or later.
PROMPT  
select count (*) count
  from purch_req_line_approval_tab pl
 where pl.requisition_no not in 
       (select pr.requisition_no 
          from purchase_requisition_tab pr
         where pr.requisition_no = pl.requisition_no);
PROMPT
PROMPT       ============================================================
PROMPT 
PROMPT         Check for missing default data in certain tables related to purchase orders.
PROMPT         
PROMPT         If these queries return row counts above zero, 
PROMPT         IFS needs to investigate this issue further.
PROMPT       
PROMPT         Likely a database that was pre-2003 at some point 
PROMPT       
PROMPT         From purch/1110a.upg:
PROMPT       FIX:  ALTER TABLE purchase_order_line_tab ADD (
PROMPT             TAXABLE              VARCHAR2(5) DEFAULT 'TRUE',
PROMPT             TAX_EXEMPT           VARCHAR2(5) DEFAULT 'FALSE' );
PROMPT       
PROMPT         See script G1500191_update_tax_exempt.sql, run as post script

--
select distinct rowstate,count (*)
  from purchase_order_line_tab 
 where taxable is null 
   and rowstate ^ = 'Closed' 
   and rowstate ^ = 'Cancelled' 
 group by rowstate
 order by rowstate;
--
--
--
select distinct rowstate,count (*)
  from purchase_order_line_tab 
 where tax_exempt is null 
   and rowstate ^ = 'Closed' 
   and rowstate ^ = 'Cancelled' 
 group by rowstate
 order by rowstate;
--
--
--
PROMPT
PROMPT       ============================================================
PROMPT          
PROMPT         Check for vendor part numbers defined in lower case.  IFS Applications
PROMPT         only allows upper cased part number entry.
PROMPT       
PROMPT         For version XXXXX
PROMPT       
PROMPT         If either query returns any row count above zero, 
PROMPT         IFS needs to investigate this issue further.
PROMPT       
PROMPT         See IFS Solution 207504
PROMPT       
PROMPT       
select count (*) count --  vendor_part_no  
  from purchase_part_supplier 
 where vendor_part_no != upper(vendor_part_no) and
       vendor_part_no != lower(vendor_part_no);
--
--
--
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5l
PROMPT
PROMPT       Invoice related 
PROMPT
PROMPT       If upgrading, this data discrepancy is fixed during upgrade pre-drop scripts
PROMPT       and no action is needed on old version.
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT         If these queries return any row count above zero,
PROMPT         this will need further investigation.  Upgrade of INVOICE to Apps 8 
PROMPT         will fail.
PROMPT       
PROMPT         ADVANCE_INV_REFERENCE_TAB rows without parent rows.
PROMPT       
PROMPT       
PROMPT       
PROMPT         Fails for IFS 2003/2004
--
select count(*)  count
  from advance_inv_reference_tab t
 where t.adv_inv_id 
   not in (select i.invoice_id 
             from invoice_tab i
            where i.company = t.company);
--
--
--
PROMPT  
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5m
PROMPT
PROMPT       DOCMAN related
PROMPT
PROMPT       Determine scope of need for upgrade script 
PROMPT       POST_DOCMAN_App8_RelocateStrandedFtpFiles.sql
PROMPT
PROMPT       Need to have a trailing slash on path name
PROMPT       Unix file paths will show as error due to SQL-Plus syntax issues 
PROMPT
set echo off;
break on report;
compute sum of count on report;
--
--
SELECT 
--t.doc_class, t.doc_no, t.doc_sheet, t.doc_rev, t.doc_type, t.file_no, t.file_name, t.location_name, t.path, l.location_type
    distinct t.path, location_type, count(*) count
    from edm_file_tab t, 
         edm_location_tab l
   where t.location_name = l.location_name
     and l.location_type = 2
     and t.path is not null
     and t.path not like ('%/')
   group by t.path,l.location_type
   order by t.path;
--
--
--
PROMPT  
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5n
PROMPT
PROMPT       PAYLED related
PROMPT
PROMPT       If these queries return any row count above zero,
PROMPT       this will need further investigation. 
PROMPT
PROMPT       If upgrading, this data discrepancy is fixed during upgrade pre-drop scripts
PROMPT       and no action is needed on old version.
PROMPT
PROMPT       ============================================================
set echo off;
clear breaks columns computes;
--
col count format 999,999,999;
--
Prompt
Prompt  Count follow up messages associated with deleted customer credit notes.
Prompt
Prompt  Orphans in follow_up_message_tab deleted during upgrade process

select count (*) count
  from follow_up_message_tab fumt
 where not exists (select 1
                     from customer_credit_note_tab
                    where customer_id = fumt.identity
                      and company     = fumt.company
                      and note_id     = fumt.note_id)
       and invoice_id is null;
--
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5o
PROMPT
PROMPT       INVENT related
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       If this query return any rows, it will most likely lead to a cost calculation failure.
PROMPT
--set timing on;
select count(*) count
  from inventory_part_tab a
 where not exists
     (select 1
        from inventory_part_config_tab b
       where b.contract = a.contract
         and b.part_no  = a.part_no
         and b.configuration_id = '*');
--
--
--
set echo off;
PROMPT
PROMPT       ============================================================
PROMPT
Prompt       This query shows parts in stock, in a location that is not in the master table of locations, 
Prompt       WAREHOUSE_BAY_BIN_TAB.
Prompt
Prompt       If this query return any rows, it will cause a failure in invent/1400.upg
Prompt
select part_no,contract,location_no 
  from inventory_part_in_stock_tab t1
 where not exists 
   (select * from warehouse_bay_bin_tab t2 
     where t1.contract    = t2.contract
       and t1.location_no = t2.location_no);
PROMPT
PROMPT       ============================================================
PROMPT 
PROMPT         Check for part numbers defined in lower case.  IFS Applications
PROMPT         only allows upper cased part number entry.
PROMPT       
PROMPT         For version XXXXX
PROMPT       
PROMPT         If either query returns any row count above zero, 
PROMPT         IFS needs to investigate this issue further.
PROMPT       
PROMPT         See IFS Solution 230194
PROMPT       

select part_no from inventory_part_config_tab
where part_no != upper(part_no) 
  and part_no != lower(part_no)
  and rownum < 101;
PROMPT
PROMPT       ============================================================
PROMPT 
PROMPT         Check for orphan records against inventory_part_tab
PROMPT 
PROMPT         If query returns any row count above zero, 
PROMPT         IFS needs to investigate this issue further.
PROMPT 
PROMPT         Orphans in inventory_part_planning_tab
PROMPT 
select count (*) 
 from inventory_part_planning_tab a
 where not exists (select 1 from inventory_part_tab b
                    where a.part_no  = b.part_no
                      and a.contract = b.contract);
PROMPT
PROMPT
PROMPT         Orphans in part_cost_tab
PROMPT 
select count (*) 
 from part_cost_tab a
 where not exists (select 1 from inventory_part_tab b
                    where a.part_no  = b.part_no
                      and a.contract = b.contract);
PROMPT
PROMPT
PROMPT         Orphans in part_revision_tab
PROMPT 
select count (*) 
 from part_revision_tab a
 where not exists (select 1 from inventory_part_tab b
                    where a.part_no  = b.part_no
                      and a.contract = b.contract);
PROMPT
PROMPT
PROMPT         Orphans in inventory_part_config_tab
PROMPT 
select count (*) 
 from inventory_part_config_tab a
 where not exists (select 1 from inventory_part_tab b
                    where a.part_no  = b.part_no
                      and a.contract = b.contract);
set timing off;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5p
PROMPT
PROMPT       MPCCOM/INVENT related
PROMPT
PROMPT       If these queries return any row count above zero,
PROMPT       there are MPCCOM transactions without corresponding 
PROMPT       Inventory_Transaction_Hist_tab row.
PROMPT       
PROMPT       Most likely due to incorrect data archiving.
PROMPT       This is an FYI only, no standard fix available.  
PROMPT
select count(*) count
  from mpccom_accounting_tab a
 where booking_source = 'INVENTORY'
   and :query5p_extended = 'Y'
   and not exists
       (select 1 from inventory_transaction_hist_tab b
         where b.accounting_id = a.accounting_id);
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5q
PROMPT
PROMPT       ORDER related
PROMPT
PROMPT       If these queries return any row count above zero,
PROMPT       they need to be investigated further.
PROMPT       
PROMPT       Most likely due to incorrect data archiving.
PROMPT       This is an FYI only, no standard fix available.  
PROMPT
PROMPT       Look for orphans in customer_order_line_tab
PROMPT
select count (*) 
  from customer_order_line_tab a 
 where not exists (select 1 from customer_order_tab b 
                    where a.order_no = b.order_no);
PROMPT
PROMPT       Look for orphans in return_material_line_tab
PROMPT
select count (*) 
  from return_material_line_tab a 
 where not exists (select 1 from return_material_tab b 
                    where a.rma_no = b.rma_no);
PROMPT  
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5r
PROMPT
PROMPT       SHPORD related 
PROMPT
PROMPT       ============================================================
set echo off;
connect &&sys_connect;
show user;
--
column package_name format a32;
column count(a.argument_name) heading 'Number|Of|Arguments';
--
Prompt  Potential issues with regenerate calendar processes
--
Prompt  ******IGNORE RESULTS Apps 7 and earlier*****
--
--  From Roy 
--  The query returns all objects that have the Calendar_Changed process and has only 
--  one parameter (calendar_id) instead of two (calendar_id and contract). 
--  It also displays whether the package body is valid or invalid.
--  If the below SQL returns rows in the upgraded database, it implies 
--  that the customer will run into 'PLS-00306: wrong number or types of arguments 
--  in call to 'CALENDAR_CHANGED'' errors at the time of generating or changing the 
--  existing calendars in the new system.  If the query returns objects belonging 
--  to SHPREP or SHPEMP and the customer upgraded to Apps8, these modules do not exist 
--  any more in Apps8. If the query returns customized package bodies, the Upgrade team would need to 
--  work with the customer to decide whether the MOD would need to be uplifted/enhanced or dropped. 
--
select a.package_name, b.status, count(a.argument_name) 
  from user_arguments a, user_objects b
 where a.object_name  = 'CALENDAR_CHANGED'
   and a.package_name = b.object_name
   and b.object_type  = 'PACKAGE BODY'
 group by a.package_name, b.status
having count(a.argument_name) = 1
 order by 1;
PROMPT  
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
PROMPT
PROMPT  Look for orphaned serial_no_reservation_tab rows
PROMPT  See bug 97709
PROMPT  If count returned is > zero, this is an issue.
PROMPT
PROMPT  These orphans are dropped during an upgrade
--
select count(*) count
  from serial_no_reservation_tab a
 where serial_reservation_source = 'SHOP ORDER'
   and not exists
(select 1 from shop_ord_tab b
  where b.order_no = a.order_ref1
    and nvl(b.release_no ,'Dummy')  = nvl( a.order_ref2, 'Dummy' )
    and nvl(b.sequence_no ,'Dummy') = nvl( a.order_ref3, 'Dummy' ));
PROMPT 
PROMPT       ============================================================
PROMPT
Prompt  This is to identify buildable/plannable/tentative recipe structures that 
Prompt  have incorrect batch size displayed in pounds. 
Prompt
Prompt  There also could be some recipe structures listed by either SQL query if 
Prompt  the sum of the component parts std_size_kg is less than the header 
Prompt  (i.e. manuf structure alternate) std_size_kg.
Prompt
Prompt  e.g. if Parent Part A is made up of components A1, A2, A3 and if the 
Prompt  sum(qty_kg) of A1, A2 and A3 equal 10, but the Parent Parts std_size_kg is 35, 
Prompt  it would show up in the output.
Prompt
Prompt  If either query returns a count > 0, a data fix will be required.  See G1462731.
Prompt
Prompt
--
--
SELECT count(*) count FROM manuf_struct_alternate_tab a
WHERE  rowtype like '%RecipeStructAlternate'
and  display_weight_uom = 'lb'
--and part_no = 'CLP03'
AND round(std_size_kg) > ROUND((SELECT SUM(qty_kg) FROM Manuf_structure_tab b
                                WHERE b.contract = a.contract
                                AND b.part_no = a.part_no
                                AND b.eng_chg_level = a.eng_chg_level
                                and qty_kg > 0
                                ))
and rowstate IN ( 'Plannable', 'Tentative'   )
AND NOT EXISTS
(SELECT 1 FROM Manuf_structure_tab b
                                WHERE b.contract = a.contract
                                AND b.part_no = a.part_no
                                AND b.eng_chg_level = a.eng_chg_level
                                AND qty_kg < 0 
);
--
--
--
select count(*) count from manuf_struct_alternate_tab a
 where  rowtype like '%RecipeStructAlternate'
   and  display_weight_uom = 'lb'
--and part_no = 'CLP03'
   and round(std_size_kg) > round((select sum(qty_kg) from manuf_structure_tab b
                                    where b.contract = a.contract
                                      and b.part_no = a.part_no
                                      and b.eng_chg_level = a.eng_chg_level
                                      and qty_kg > 0
                                  ))
   and rowstate = 'Buildable'   
   and not exists
      (select 1 from manuf_structure_tab b
               where b.contract = a.contract
                 and b.part_no = a.part_no
                 and b.eng_chg_level = a.eng_chg_level
                 and qty_kg < 0 
       );
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT 
PROMPT       ============================================================
PROMPT
Prompt  Check for data in PLANNING_ALERT_TAB for closed shop orders
Prompt
Prompt  For version ??
Prompt 
Prompt  If either query returns any row count above zero
Prompt  IFS needs to investigate this issue further.
Prompt
Prompt  See patch 73067 and 109333
Prompt
Prompt  If upgrading, this data discrepancy is fixed during upgrade pre-drop scripts
Prompt  and no action is needed on old version.
Prompt
Prompt  Orphans deleted during upgrade process
--
select count(*) count 
  from planning_alert_tab a 
 where exists 
     (select 1 from shop_ord_tab b 
       where b.order_no = a.order_no 
         and b.release_no = a.release_no 
         and b.sequence_no = a.sequence_no 
         and b.rowstate = 'Closed');
--
--
PROMPT 
PROMPT       ============================================================
PROMPT
Prompt  Orphans deleted during upgrade process
Prompt
--
select count(*) count 
  from planning_alert_tab a 
 where not exists 
     (select 1 from shop_ord_tab b 
       where b.order_no    = a.order_no 
         and b.release_no  = a.release_no 
         and b.sequence_no = a.sequence_no);
--
--
PROMPT 
PROMPT       ============================================================
PROMPT
Prompt  Below identifies orphans in SHOP_ORD_TAB vs INVENTORY_PART_PLANNING_TAB
--  [SHPORD][080926_72526_SHPORD.cdb][Timestamp_2]]
--  
select count (*) count 
  from shop_ord_tab a
 where not exists
     (select 1 from inventory_part_planning_tab b 
        where b.part_no  = a.part_no
          and b.contract = a.contract);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5s
PROMPT
PROMPT       COST related 
PROMPT
PROMPT       ============================================================
PROMPT
clear breaks columns computes;
--
column count format 999,999 justify right heading 'Count';
--
--
PROMPT  Will cause problems with upgrade, cost\1200.upg
PROMPT  See G1431251
PROMPT  
PROMPT  Should not be an issue for Apps 9 upgrades which fixed cost/1200.upg
PROMPT
select count(*) count 
  from part_cost_tab 
 where (part_no, contract) not in (select part_no, contract from inventory_part_planning_tab);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 5 Data Inconsistencies
PROMPT
PROMPT       Query 5t
PROMPT
PROMPT       PROJ related 
PROMPT
PROMPT       ============================================================
PROMPT
clear breaks columns computes;
--
column count format 999,999,999,999 justify right heading 'Count';
set timing on;
--
PROMPT
PROMPT       If any counts are > 0, need to investigate further
PROMPT
--  Count records from activity_history_tab where a corresponding record in
--  project_history_log_tab does not exist, by project_id
--
select count(*) count from activity_history_tab ah
 where not exists (select 1
                     from project_history_log_tab ph
                    where ph.project_id = ah.project_id);
--
--
--
--  Count records from activity_history_tab where a corresponding record in
--  project_history_log_tab does not exist, by hist_seq_no
--
select count (*) count from activity_history_tab b
 where not exists (select (1) from project_history_log_tab a
                    where a.hist_seq_no = b.parent_hist_seq_no);
--
--
--
--  See PROJ 200.upg  Timestamp_105
--  Count records from project_connection_history_tab where a corresponding record in
--  project_history_log_tab does not exist
--
select count (*) count
  from project_connection_history_tab pch
 where exists (select 1
                 from activity_history_tab ah
                where pch.activity_seq = ah.activity_seq
                  and not exists (select 1
                                    from project_history_log_tab ph
                                   where ph.project_id = ah.project_id));
--
--
--
--  Count records from proj_conn_details_history_tab where a corresponding record in
--  project_history_log_tab does not exist
--
select count (*) count from proj_conn_details_history_tab pcdh
 where exists (select 1
                 from activity_history_tab ah
                where pcdh.activity_seq = ah.activity_seq
                  and not exists (select 1
                                    from project_history_log_tab ph
                                   where ph.project_id = ah.project_id));
--
--
--
--  Look for proj_conn_details_history_tab rows with no parent row
--  Will cause upgrade proj/200 to fail so these orphaned detail rows 
--  are dropped as part of upgrade pre-scripts.
--
select count (*) count from proj_conn_details_history_tab b
 where not exists (select (1) from project_connection_history_tab a
                    where a.hist_seq_no = b.parent_hist_seq_no);
--
--
--
--  Look for project_connection_history_tab rows with no parent row
--				
select count (*) count from project_connection_history_tab b
 where not exists (select (1) from project_history_log_tab a
                    where a.hist_seq_no = b.parent_hist_seq_no);
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
set timing off;
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6a
PROMPT
PROMPT       Determine number of rows in General Ledger related tables
PROMPT       Not executed.
PROMPT       ============================================================
--
set feedback on;
--
--
--connect &&sys_connect;
--show user;
----
--clear breaks columns computes;
----
--column table_name format a35;
--column count      format 9,999,999,999;
--column num_rows   format 9,999,999,999;
----
----test stats accuracy
----
--select table_name, tablespace_name, num_rows  
  --from dba_tables
 --where owner = :ifsappowner_uc
   --and(table_name = 'GEN_LED_VOUCHER_ROW_TAB'  
    --or table_name = 'INTERNAL_HOLD_VOUCHER_ROW_TAB'
    --or table_name = 'INTERNAL_VOUCHER_ROW_TAB'  
    --or table_name = 'INVOICE_ITEM_TAB'
    --or table_name = 'MPCCOM_ACCOUNTING_TAB')
 --order by table_name;
----
----
--connect &&ifsappowner_connect;
--show user;
--set echo off;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
--Prompt gen_led_voucher_row_tab
--select count (*) count from gen_led_voucher_row_tab;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
--Prompt internal_hold_voucher_row_tab
--select count (*) count from internal_hold_voucher_row_tab;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
--Prompt internal_voucher_row_tab
--select count (*) count from internal_voucher_row_tab;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
--Prompt invoice_item_tab
--select count (*) count from invoice_item_tab;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
--Prompt mpccom_accounting_tab
--select count (*) count from mpccom_accounting_tab;
----
--select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
----
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6b
PROMPT
PROMPT       Determine number of Projects and Activity Dates
PROMPT
PROMPT       ============================================================
PROMPT
--
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break on history_year skip 1 on report;
compute sum of count on report;
compute sum of history_count on report;
column history_count                format 9,999,999,999;
column count                        format 999,999,999;
column project_status               format a20;
column close_date                   format a12 heading 'Close|Date';
column date_last_activity_by_status format a12 heading 'Date Last|Activity';
--
PROMPT
PROMPT  Project count by status
PROMPT
--
select distinct rowstate project_status,
       count(*) count, 
       max(rowversion) date_last_activity_by_status,
       max(close_date) close_date
  from project_tab
 group by rowstate
 order by rowstate;
--
--
Prompt
Prompt  Review Project Connection History usage
PROMPT
--
select distinct extract(year from a.history_date) History_year,
       b.rowstate project_status,       
       count(a.history_date) History_count,
       max(b.rowversion) date_last_activity_by_status,
       max(b.close_date) close_date
  from proj_conn_details_history_tab a,
       project_tab b
 where a.project_id(+) = b.project_id
 group by extract(year from a.history_date), b.rowstate
 order by extract(year from a.history_date), b.rowstate;
--
Prompt
Prompt  Number of Project Snapshot rows
PROMPT
--
select count (*) count from project_snapshot_data_tab;
--
Prompt
Prompt  Number of Activity Cost rows
PROMPT
--
select count (*) count from activity_cost_tab;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
--
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6c
PROMPT
PROMPT       Document Management usage
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column count          format 9,999,999,999;
column document_count format 9,999,999,999;
column vault_count    format 9,999,999,999;
column doc_class      format a12;
column file_type      format a30;
column rowkey noprint;
--
PROMPT  Determine number of documents being stored in Document Management
PROMPT  
select count (*) count from edm_file_tab;
PROMPT
PROMPT  Query for Document Vaults
PROMPT
PROMPT  Location_Type 1 = Shared
PROMPT  Location_Type 2 = FTP
PROMPT  Location_Type 3 = Database
--
break   on report;
compute sum of count on report;
--
select distinct location_type, count (*) vault_count
  from edm_location_tab 
 group by location_type
 order by location_type;
--
--
--
select distinct location_type, count (*) document_count
  from edm_location_tab elt,
       edm_file_tab eft 
 where elt.location_name = eft.location_name
 group by location_type
 order by location_type;
--
--
--
select e.*,
 '_______________________________________________________________________________________________________________________________________________' 
 from edm_location_user_tab e;
--
--
--
select e.location_type,e.*,
 '_______________________________________________________________________________________________________________________________________________' 
 from edm_location_tab e
order by e.location_type, e.doc_class, e.location_name;
--
--
--
--  Query for Document Classes, File Types and counts
--
select distinct doc_class,
       file_type,
	   count (*) count
  from edm_file_tab 
 group by doc_class,file_type
 order by doc_class,file_type;
--
--
--
--  Identify potential upgrade issue related to documents being stored in FTP sites
--
-- SELECT t.doc_class, t.doc_no, t.doc_sheet, t.doc_rev, t.doc_type, t.file_name, t.location_name, t.path, l.location_type
--    FROM EDM_FILE_TAB t, EDM_LOCATION_TAB l
--    WHERE t.location_name = l.location_name
--    AND l.location_type = 2
--    AND t.path IS NOT NULL
--    AND t.path NOT LIKE ('%/');
--
clear breaks columns computes;
column count format 9,999,999,999;
--
select count (*) count
  from edm_file_tab t, edm_location_tab l
 where t.location_name = l.location_name
   and l.location_type = 2
   and t.path is not null
   and t.path not like ('%/');
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6d
PROMPT
PROMPT       Determine number of Shop Orders and their state
PROMPT       Determine number of rows in Shop Order related tables
PROMPT
PROMPT       ============================================================
set echo off;
--
connect &&ifsappowner_connect;
show user;
--
--
clear breaks columns computes;
--
column count format 9,999,999,999;
--
Prompt  Count rows in operation_history_tab
Prompt
select count (*) count from operation_history_tab;

clear breaks columns computes;
--
Break on site skip 2 on year skip 1 on report
compute sum of count on report;
compute sum of count on site;
--
column rowstate format a15 heading 'Shop Order|Status'
column count    format 9,999,999,999;
column year heading 'Org Due|Date Year'
--
Prompt Shop Orders by site and their status
--
select distinct contract site, 
       extract(year from org_due_date) year, rowstate,
       count (*) count
  from shop_ord_tab 
 group by contract, extract(year from org_due_date), rowstate
 order by contract, extract(year from org_due_date), rowstate;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6e
PROMPT
PROMPT       Determine number of Customer Orders and their state
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
break on site skip 2 on year skip 1 on report;
compute sum of count on report;
compute sum of count on site;
column year heading 'Wanted|Delivery|Date Year';
column count format 9,999,999,999;
column rowstate format a22 heading 'Customer Order|Status';
--
Prompt Customer Orders by site and their status
--
select distinct contract site, 
       extract(year from wanted_delivery_date) year, rowstate,
       count (*) count
  from customer_order_tab
 group by contract, extract(year from wanted_delivery_date), rowstate
 order by contract, extract(year from wanted_delivery_date), rowstate;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6f
PROMPT
PROMPT       Number of Purchase Order Lines and Requisition Lines and 
PROMPT       their state
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
Break on site skip 2 on year skip 1 on report;
compute sum of count on report;
compute sum of count on site;
column year heading 'Last|Activity|Date Year';
column count format 9,999,999,999;
column rowstate format a22 heading 'Purchase Order|Line Status';
--
Prompt Purchase Order Lines by site and their status
--
select distinct contract site, 
       extract(year from last_activity_date) year, rowstate,
       count (*) count
  from purchase_order_line_tab
 group by contract, extract(year from last_activity_date), rowstate
 order by contract, extract(year from last_activity_date), rowstate;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
-- 
column rowstate format a22 heading 'Purchase Req|Line Status';
--
Prompt Purchase Requisition Lines by site and their status
--
select distinct contract site, 
       extract(year from rowversion) year, rowstate,
       count (*) count
  from purchase_req_line_tab
 group by contract, extract(year from rowversion), rowstate
 order by contract, extract(year from rowversion), rowstate;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
-- 
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6g
PROMPT
PROMPT       Determine number of Equipment Objects, Work Orders and their state
PROMPT
PROMPT       ============================================================
--
set echo off;
--
clear breaks columns computes;
--
break on year skip 1 on report;
compute sum of count on year;
compute sum of count on report;
column year heading 'Real -F-|Date Year';
column count format 9,999,999,999;
column wo_status_id format a22 heading 'Work Order|Status';
Prompt  Count rows in equipment_object_tab
Prompt
select count (*) count from equipment_object_tab;
--
Prompt Historic Work Orders and their status
--
select distinct extract(year from real_f_date) year,
       wo_status_id, 
       count (*) count
  from historical_work_order_tab
 group by extract(year from real_f_date), wo_status_id
 order by extract(year from real_f_date), wo_status_id;
--
--
column year heading 'Last|Activity|Date';
--
Prompt Active Work Orders and their status
--
select distinct extract(year from last_activity_date) year,
       wo_status_id, 
       count (*) count
  from active_work_order_tab
 group by extract(year from last_activity_date), wo_status_id
 order by extract(year from last_activity_date), wo_status_id;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6h
PROMPT
PROMPT       Determine number of inventory parts and their status
PROMPT       Related to potential upgrade issue - review before and after upgrade
PROMPT
PROMPT       ============================================================
--
set echo off;
--
clear breaks columns computes;
--
break on contract skip 2 on report;
compute sum of count on contract;
compute sum of count on report;
column part_status format a10 heading 'Part|Status';
column count format 9,999,999,999;
--
Prompt Inventory Parts and their status
--
select distinct contract, part_status, count(*) count 
  from inventory_part_tab 
 group by contract, part_status 
 order by contract, part_status;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 6 Data Volumes
PROMPT
PROMPT       Query 6i
PROMPT
PROMPT       Data volumes for BA/BI
PROMPT       Cleanup:  XLR_TEMPLATE_UTIL_API.Cleanup_System_Templates____ 
PROMPT                 when scheduled deletes the data.  Scheduled Task = Cleanup System Templates
PROMPT
PROMPT       ============================================================
set echo off;
connect &&sys_connect;
show user;
--
clear breaks columns computes;
--
column table_name      format a35;
column tablespace_name format a30;
column num_rows        format 9,999,999,999;
--
--
select table_name, tablespace_name, num_rows  
  from dba_tables
 where owner = :ifsappowner_uc
   and table_name like 'DSOD%'
 order by table_name;
PROMPT
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       Set 7 IFS Apps Configuration 
PROMPT
PROMPT       Query 7a
PROMPT
PROMPT       List F1 Configuration Parameters
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column parameter      format a25;
column parameter_desc format a50;
column value          format a40;
column value_type     format a20;
-- 
-- Default Language must be set in order for upgrade post scripts
-- to work correctly
--
PROMPT       Fails for IFS 2003
--
select parameter, parameter_desc, value, Value_type 
  from fnd_setting_tab 
 where parameter = 'DEFAULT_LANGUAGE'
 order by 1;
--
--
--
column parameter_desc format a71;
column value          format a25;
--
select parameter,parameter_desc, value  from fnd_setting_tab 
 order by 1;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT       ============================================================
PROMPT
PROMPT       Set 8 Data cleanup required for upgrade
PROMPT
PROMPT       Query 8a
PROMPT
PROMPT       Determine use of DISCRETE UOMs
PROMPT
PROMPT       NOTE:  This query is showing ONLY the first 25 parts with this issue!!!
PROMPT
PROMPT       In APICS standards the term "Discrete" represents a distinct 
PROMPT       item that is always inventoried as a whole integer, 
PROMPT       such as a paper bag or a coffee pot. 
PROMPT
PROMPT       This query identifies UOMs defined by customer to be Discrete.
PROMPT
PROMPT       Some UOMs do not make sense to be Discrete, such as 
PROMPT       "Sheet, Coil, 72case" etc, because the entire integer is not
PROMPT       always consumed in the manufacturing process. 
PROMPT
PROMPT       Previous versions of IFS did not have the multiple uom functionality 
PROMPT       that Apps 8 now has, and this poor choice of data set-up will 
PROMPT       potentially cause issues with Apps 8.
PROMPT       
PROMPT       If you have active parts with a UOM which is defined as Discrete,
PROMPT       and you DO have transactions which would involve numbers that 
PROMPT       are NOT whole integers, further discussion with IFS is needed.
PROMPT 
PROMPT       ============================================================
set echo off;
-- 
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column count format 9,999,999;
--
--
select * from 
(
select part_no, contract site, ipt.unit_meas, iut.unit_type, ipt.last_activity_date 
  from inventory_part_tab ipt,
       iso_unit_tab iut
 where ipt.unit_meas = iut.unit_code 
   and iut.unit_type = 'DISCRETE'
 order by part_no,contract
)
where rownum < 26;
--
--
--
select distinct unit_meas, count (*) count
  from inventory_part_tab ipt,
       iso_unit_tab iut
 where ipt.unit_meas = iut.unit_code
   and iut.unit_type = 'DISCRETE'
 group by unit_meas
 order by unit_meas;
--
PROMPT
PROMPT       ============================================================
PROMPT 
PROMPT       Set 8 Data cleanup required for upgrade
PROMPT       
PROMPT       Query 8b
PROMPT
PROMPT       Check for transfer of inventory transactions to MPCCOM_ACCOUNTING_TAB
PROMPT
PROMPT       Inventory transactions need to be transferred to the GL on a regular basis.  
PROMPT       Transactions with status 99 are in an ERROR status and must be 
PROMPT       investigated and resolved by customer before they will transfer cleanly.
PROMPT
PROMPT       PRIOR TO final upgrade pass, all such transactions must have already 
PROMPT       been transferred to the General Ledger without error.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
set echo off;
--
clear breaks columns computes;
--
column count          format 999,999,999;
column status         format a6;
column newest_voucher format a15;
column oldest_voucher format a15;
break on report;
compute sum of count on report;
--
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT          Verified for 2003, 2004 sp3/sp6
PROMPT          Will fail later versions
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
--
select distinct i.contract site, m.status_code status, count(*) count,
       min(date_voucher) oldest_voucher, 
       max(date_voucher) newest_voucher
  from mpccom_accounting_tab m, inventory_transaction_hist_tab i 
 where m.status_code != '3' 
   and m.booking_source = 'INVENTORY' 
   and m.accounting_id = i.accounting_id
 group by i.contract, m.status_code
 order by i.contract, m.status_code;
--
--
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT          Will fail for 2003, 2004 SP3/SP6
PROMPT
PROMPT          Verified for Apps 7 SP2 --> Apps 10
PROMPT
PROMPT       ============================================================
PROMPT
set echo off;
--
select distinct contract site, status_code status, count (*) count, 
       min(date_applied) oldest_voucher, 
       max(date_applied) newest_voucher
  from mpccom_accounting_tab 
 where status_code != '3'       
   and booking_source = 'INVENTORY'
 group by contract, status_code
 order by contract, status_code;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 8 Data cleanup required for upgrade
PROMPT       
PROMPT       Query 8c
PROMPT
PROMPT       Check for inventory statistics update job execution status.
PROMPT
PROMPT       Inventory statistics need to be updated on a regular basis.  
PROMPT       If you have results for SITES that are OLDER than the last date
PROMPT       you ran Inventory Statistics Update, there is some sort of error.
PROMPT       
PROMPT       PRIOR TO final upgrade pass, all inventory statistics must  
PROMPT       be updated without any remaining errors.
PROMPT
PROMPT       ============================================================
PROMPT
connect &&ifsappowner_connect;
show user;
--
set echo off;
--
clear breaks columns computes;
--
column count              format 999,999,999;
column newest_not_updated format a15 heading 'Newest|Not|Updated';
column oldest_not_updated format a15 heading 'Oldest|Not|Updated';
break on report;
compute sum of count on report;
--
--     Verified for 2003 SP3/4
--     Verified for 2004 SP3/SP6
--     Verified for 7.0 SP3
--     Verified for 7.5 SP5/SP6
--     Verified for 8.0 SP1
--
select contract site, count (*) count, 
   min(date_applied) oldest_not_updated, 
   max(date_applied) newest_not_updated
  from inventory_transaction_hist_tab
 where partstat_flag = 'N' or valuestat_flag = 'N'
 group by contract
 order by contract;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
PROMPT
PROMPT       ============================================================
PROMPT
PROMPT       Set 8 Data cleanup required for upgrade
PROMPT       
PROMPT       Query 8d - Check Language_sys_tab for rows to be dropped during Apps 8 upgrade
PROMPT       SO and RWC not required to be in Language_Sys_Tab in Apps 8.
PROMPT
PROMPT       ============================================================
set echo off;
connect &&ifsappowner_connect;
show user;
--
clear breaks columns computes;
--
column count        format 999,999,999;
column main_type    format a15 heading 'Main|Type';
column status       format a8  heading 'Active|Passive';
column installed    format a10;
column description  format a25;
column refresh_date format a21;
break on report on status skip 1;
compute sum of count on report;
--
select distinct main_type, count (*) count from language_sys_tab
 group by main_type 
 order by main_type;
--
--
select status, lang_code, description, installed, 
       to_char (dictionary_update, 'mm-dd-yyyy  hh24:mi:ss') Refresh_date
  from language_code_tab order by status, lang_code;

select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
--  ============================================================
--  Be sure connected as IFSAPPOWNER before returning
--  ============================================================
--
clear breaks columns computes;
--
connect &&ifsappowner_connect;
show user;
--
column task_details format a80;
column timestamp    format a31;
--
PROMPT  
PROMPT       List contents of upgrade_activity_logging_tab
PROMPT  
select task, to_char(timestamp, 'mm-dd-yyyy   hh24:mi:ss:ff3   ') 
time_stamp, task_details from upgrade_activity_logging_tab order by timestamp, task_details;
--
select to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') date_time from dual;
-- 
set echo on;
spool off;
set timing off;
