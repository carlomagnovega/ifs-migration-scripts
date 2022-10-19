DECLARE   
   CURSOR get_qaman IS
      SELECT OBJID,
			 OBJVERSION,
			 WEB_USER
	  FROM fnd_user
	 WHERE ACTIVE = 'TRUE'
	   AND ORACLE_USER NOT IN ('AMER1APP',
							   'IFSPRINT',
							   'IFSPLSQLAP',
							   'IFSCONNECT',
							   'IFSADMIN',
							   'IFSANONYMOUS',
							   'TEST-USER-IFS1',
							   'TEST',
							   'PRINT',
							   'IFSINFO',
							   'IFSMOBILITY')
	   AND WEB_USER NOT LIKE '%@AIMFIRE.NET';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);   
   attr_                VARCHAR2(26000);
   domain_              VARCHAR2(26000);   
BEGIN
   domain_ := '@AIMFIRE.NET';
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('WEB_USER', row_.WEB_USER || domain_, attr_);
 
	  Fnd_User_API.Modify__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;