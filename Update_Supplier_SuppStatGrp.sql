DROP TABLE MTK_SUPPLIER_AIM_TAB;

CREATE TABLE MTK_SUPPLIER_AIM_TAB 
(
   SUPPLIER_ID   VARCHAR2(20)        NOT NULL,
   Supp_Grp      VARCHAR2(100)       NULL  
);

SELECT 'INSERT INTO MTK_SUPPLIER_AIM_TAB (SUPPLIER_ID,Supp_Grp) VALUES (''' 
		+ [SUPPLIER_ID]
		+ ''',''' + ISNULL([cf$_aim_id_trib_reg], '')
		+ ''',''' + ISNULL([cf$_aim_fiscal_res], '')
		+ ''',''' + [Supp_Grp]
		+  ''');'   aa
FROM ( SELECT CAST([SUPPLIER_ID] AS VARCHAR)	[SUPPLIER_ID]
	  ,[Supp_Grp]
	  FROM [IFSDEV-ManualUpload].[dbo].[PROD$]) aaa  

---Update Supplier SUPP_GRP
DECLARE   
   CURSOR get_qaman IS
      SELECT d.objid,            
             d.objversion
      FROM IDENTITY_INVOICE_INFO b
      LEFT JOIN IDENTITY_PAY_INFO c ON b.supplier_id = c.identity AND b.COMPANY = c.COMPANY AND b.PARTY_TYPE = c.PARTY_TYPE
      INNER JOIN SUPPLIER_ENT d ON d.SUPPLIER_ID = b.supplier_id
      WHERE B.SUPPLIER_ID IN ('6500','6501','6502','6503','6504','6505','6506','6507','6508','6510','6511','6512','6513','6514','6515','6516','6517','6518','6519','6520','6521','6522','6523','6524','6525','6526','6528','6533','6534','6535','6536','6537','6538','6539','6540','6541','6542','6543','6544','6545','6546','6547','6548','6549','6550','6551','6552','6553','6554','6555','6556','6557','6558','6559','6560','6561','6562','6563','6564','6565','6566','6567','6568','6569','6570','6571','6572','6574','6575','6576','6577','6578','6579','6580','6581','6582','6583','6584','6585','6586','6587','6588','6589','6590','6591','6592','6593','6594','6595','6596','6597','6598','6599','6600','6601','6602','6603','6604','6605','6606','6607','6608','6609','6610','6611','6612','6613','6614','6615','6616','6617','6618','6619','6620','6621','6622','6623','6624','6625','6626','6627','6628','6629','6630','6631','6632','6633','6634','6635','6636','6637','6638','6639','6640','6641','6642','6643','6644','6645','6646','6647','6648','6649','6650','6652','6653','6654','6655','6656','6657','6658','6659','6660','6661','6662','6663','6664','6665','6666','6667','6668','6669','6670','6671','6672','6673','6674','6675','6676','6677','6678','6679','6680','6681','6682','6683','6684','6685','6686','6687','6688','6689','6690','6691','6692','6693','6694','6695','6696','6697','6698','6699','6700','6701','6702','6703','6704','6705','6706','6707','6708','6709','6710','6711','6712','6713','6714','6715','6716','6717','6718','6719','6720','6721','6722','6723','6724','6725','6726','6727','6728','6729','6730','6731','6732','6733','6734','6735','6736','6737','6738','6739','6740','6741','6742','6743','6744','6745','6746','6747','6748','6749','6750','6751','6752','6753','6754','6755','6756','6757','6758','6759','6760','6761','6762','6763','6764','6765','6766','6767','6768','6769','6770','6771','6772','6773','6774','6775','6776','6777','6779','6780','6781','6782','6783','6784','6785','6786','6787','6788','6789','6790','6791','6792','6793','6794','6795','6796','6797','6798','6799','6800','6801','6802','6803','6804','6805','6806','6807','6808','6809','6810','6811','6812','6813','6814','6815','6816','6817','6818','6819','6820','6821','6822','6823','6824','6825','6826','6827','6828','6829','6830','6831','6832','6833','6834','6835','6836','6837','6838','6839','6840','6841','6842','6843','6844','6845','6846','6847','6848','6849','6850','6851','6852','6853','6855','6856','6857','6858','6859','6860','6861','6862','6863','6864','6865','6866','6867','6868','6869','6870','6871','6872','6873','6874','6875','6876','6877','6878','6879','6881','6882','6883','6884','6885','6886','6887','6888','6889','6890','6891','6892','6893','6894','6895','6896','6897','6898','6899','6900','6901','6902','6903','6904','6905','6906','6907','6908','6909','6910','6911','6912','6913','6914','6915','6916','6917','6918','6919','6920','6921','6922','6924','6925','6926','6927','6928','6929','6930','6931','6932','6933','6934','6935','6936','6937','6938','6939','6940','6941','6942','6943','6944','6945','6946','6947','6948','6949','6950','6951','6952','6953','6954','6955','6956','6957','6958','6959','6960','6961','6962','6963','6964','6965','6966','6967','6968','6969','6970','6971','6972','6973','6974','6975','6976','6977','6978','6979','6980','6981','6982','6983','6984','6985','6986','6987','6988','6989','6990','6991','6992','6993','6994','6995','6996','6997','6998','6999','7000','7001','7002','7003','7004','7005','7006','7007','7008','7009','7010','7011','7012','7013','7014','7015','7016','7017','7018','7019','7020','7021','7022','7023','7024','7025','7026','7027','7028','7029','7030','7031','7033','7034','7035','7036','7037','7038','7039','7040','7041','7042','7043','7044','7045','7046','7048','7049','7050','7051','7052','7053','7054','7055','7056','7057','7058','7059','7060','7061','7062','7063','7064','7065','7066','7067','7068','7069','7070','7071','7072','7073','7074','7075','7076','7077','7078','7079','7080','7081','7082','7083','7084','7085','7086','7087','7088','7089','7090','7091','7092','7093','7094','7095','7096','7097','7098','7099','7100','7101','7102','7103','7104','7105','7106','7107','7108','7109','7110','7111','7112','7113','7114','7115','7116','7117','7118','7119','7120','7121','7122','7123','7124','7125','7126','7127','7128','7129','7130','7131','7132','7133','7134','7135','7136','7137','7138','7139','7140','7141','7142','7143','7144','7145','7146','7147','7148','7149','7150','7151','7152','7153','7154','7155','7156','7157','7158','7159','7160','7161','7162','7163','7164','7165','7166','7167','7168','7169','7170','7172','7173','7174','7175','7176','7177','7178','7179','7180','7181','7182','7183','7184','7185','7186','7187','7188','7189','7190','7191','7192','7193','7194','7195','7196','7197','7198','7199','7200','7201','7202','7203','7204','7205','7206','7207','7208','7209','7210','7211','7212','7213','7214','7215','7216','7217','7218','7219','7220','7221','7222','7223','7224','7225','7226','7227','7228','7229','7230','7231','7232','7233','7234','7235','7236','7237','7238','7239','7240','7241','7242','7243','7244','7245','7246','7248','7249','7250','7251','7252','7253','7254','7256','7257','7258','7259','7260','7261','7262','7263','7264','7265','7266','7267','7268','7269','7270','7271','7272','7273','7274','7275','7276','7277','7278','7280','7282','7283','7284','7285','7286','7287','7288','7289','7290','7291','7292','7293','7294','7295','7296','7297','7298','7299','7300','7301','7302','7303','7304','7305','7306','7307','7308','7309','7310','7311','7312','7313','7314','7315','7316','7317','7318','7319','7320','7321','7322','7323','7324','7325','7326','7327','7328','7329','7330','7331','7332','7333','7334','7335','7336','7337','7338','7339','7340','7341','7342','7343','7344','7345','7346','7347','7348','7349','7350','7351','7352','7353','7354','7355','7356','7357','7358','7359','7360','7361','7362','7363','7364','7365','7366','7367','7368','7369','7370','7371','7372','7373','7374','7375','7376','7377','7378','7379','7380','7381','7382','7383','7384','7385','7386','7387','7388','7389','7390','7391','7392','7393','7394','7395','7396','7397','7398','7399','7400','7401','7402','7403','7404','7405','7406','7407','7408','7409','7410','7411','7412','7413','7414','7415','7416','7417','7418','7419','7420')
      AND b.PARTY_TYPE = 'Supplier'
      AND b.IDENTITY_TYPE_DB = 'EXTERN'
      AND d.SUPP_GRP <> 'OTHEREXP';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SUPP_GRP', 'OTHEREXP', attr_);
      
      SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;

----------------------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT d.objid,            
			   d.objversion,
			   e.Supp_Grp
		FROM IDENTITY_INVOICE_INFO b
		LEFT JOIN IDENTITY_PAY_INFO c ON b.supplier_id = c.identity AND b.COMPANY = c.COMPANY AND b.PARTY_TYPE = c.PARTY_TYPE
		INNER JOIN SUPPLIER_ENT d ON d.SUPPLIER_ID = b.supplier_id
		INNER JOIN MTK_SUPPLIER_AIM_TAB e ON e.SUPPLIER_ID = b.supplier_id
		WHERE b.PARTY_TYPE = 'Supplier'
      AND b.IDENTITY_TYPE_DB = 'EXTERN'
      GROUP BY d.objid,d.objversion,e.Supp_Grp;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SUPP_GRP', row_.Supp_Grp, attr_);
      
      SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;
-----------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  a.objid,            
              a.objversion,
              a.SUPPLIER_ID,
              c.SUPP_GRP
      FROM SUPPLIER_ENT a
      INNER JOIN MTK_SUPPLIER_AIM_TAB c ON a.SUPPLIER_ID = c.SUPPLIER_ID
      WHERE (a.SUPPLIER_ID = '9041' OR a.SUPPLIER_ID = '9087' OR a.SUPPLIER_ID = '9054' OR a.SUPPLIER_ID = '9153' OR a.SUPPLIER_ID = '9044' OR a.SUPPLIER_ID = '9083' OR a.SUPPLIER_ID = '9029' OR a.SUPPLIER_ID = '9075' OR a.SUPPLIER_ID = '9115' OR a.SUPPLIER_ID = '9074' OR a.SUPPLIER_ID = '9125' OR a.SUPPLIER_ID = '9151' OR a.SUPPLIER_ID = '9097' OR a.SUPPLIER_ID = '9082' OR a.SUPPLIER_ID = '9114' OR a.SUPPLIER_ID = '9135' OR a.SUPPLIER_ID = '9058' OR a.SUPPLIER_ID = '9080' OR a.SUPPLIER_ID = '9016' OR a.SUPPLIER_ID = '9026' OR a.SUPPLIER_ID = '9031' OR a.SUPPLIER_ID = '9081' OR a.SUPPLIER_ID = '9120' OR a.SUPPLIER_ID = '9038' OR a.SUPPLIER_ID = '9063' OR a.SUPPLIER_ID = '9140' OR a.SUPPLIER_ID = '9148' OR a.SUPPLIER_ID = '9002' OR a.SUPPLIER_ID = '9004' OR a.SUPPLIER_ID = '9113' OR a.SUPPLIER_ID = '9068' OR a.SUPPLIER_ID = '9154' OR a.SUPPLIER_ID = '9032' OR a.SUPPLIER_ID = '9049' OR a.SUPPLIER_ID = '9073' OR a.SUPPLIER_ID = '9118' OR a.SUPPLIER_ID = '9150' OR a.SUPPLIER_ID = '9005' OR a.SUPPLIER_ID = '9072' OR a.SUPPLIER_ID = '9111' OR a.SUPPLIER_ID = '9069' OR a.SUPPLIER_ID = '9103' OR a.SUPPLIER_ID = '9131' OR a.SUPPLIER_ID = '9008' OR a.SUPPLIER_ID = '9094' OR a.SUPPLIER_ID = '9139' OR a.SUPPLIER_ID = '9147' OR a.SUPPLIER_ID = '9152' OR a.SUPPLIER_ID = '9007' OR a.SUPPLIER_ID = '9019' OR a.SUPPLIER_ID = '9043' OR a.SUPPLIER_ID = '9055' OR a.SUPPLIER_ID = '9066' OR a.SUPPLIER_ID = '9099' OR a.SUPPLIER_ID = '9022' OR a.SUPPLIER_ID = '9040' OR a.SUPPLIER_ID = '9076' OR a.SUPPLIER_ID = '9021' OR a.SUPPLIER_ID = '9039' OR a.SUPPLIER_ID = '9051' OR a.SUPPLIER_ID = '9067' OR a.SUPPLIER_ID = '9071' OR a.SUPPLIER_ID = '9095' OR a.SUPPLIER_ID = '9077' OR a.SUPPLIER_ID = '9100' OR a.SUPPLIER_ID = '9137' OR a.SUPPLIER_ID = '9079' OR a.SUPPLIER_ID = '9014' OR a.SUPPLIER_ID = '9089' OR a.SUPPLIER_ID = '9102' OR a.SUPPLIER_ID = '9128' OR a.SUPPLIER_ID = '9062' OR a.SUPPLIER_ID = '9088' OR a.SUPPLIER_ID = '9092' OR a.SUPPLIER_ID = '9124' OR a.SUPPLIER_ID = '9145' OR a.SUPPLIER_ID = '9105' OR a.SUPPLIER_ID = '9119' OR a.SUPPLIER_ID = '9028' OR a.SUPPLIER_ID = '9052' OR a.SUPPLIER_ID = '9017' OR a.SUPPLIER_ID = '9098' OR a.SUPPLIER_ID = '9141' OR a.SUPPLIER_ID = '9006' OR a.SUPPLIER_ID = '9012' OR a.SUPPLIER_ID = '9046' OR a.SUPPLIER_ID = '9047' OR a.SUPPLIER_ID = '9048' OR a.SUPPLIER_ID = '9104' OR a.SUPPLIER_ID = '9018' OR a.SUPPLIER_ID = '9149' OR a.SUPPLIER_ID = '9003' OR a.SUPPLIER_ID = '9033' OR a.SUPPLIER_ID = '9035' OR a.SUPPLIER_ID = '9086' OR a.SUPPLIER_ID = '9090' OR a.SUPPLIER_ID = '9107' OR a.SUPPLIER_ID = '9009' OR a.SUPPLIER_ID = '9146' OR a.SUPPLIER_ID = '9010' OR a.SUPPLIER_ID = '9050' OR a.SUPPLIER_ID = '9144' OR a.SUPPLIER_ID = '9155' OR a.SUPPLIER_ID = '9013' OR a.SUPPLIER_ID = '9037' OR a.SUPPLIER_ID = '9057' OR a.SUPPLIER_ID = '9060' OR a.SUPPLIER_ID = '9084' OR a.SUPPLIER_ID = '9101' OR a.SUPPLIER_ID = '9121' OR a.SUPPLIER_ID = '9078' OR a.SUPPLIER_ID = '9133' OR a.SUPPLIER_ID = '9027' OR a.SUPPLIER_ID = '9061' OR a.SUPPLIER_ID = '9110' OR a.SUPPLIER_ID = '9015' OR a.SUPPLIER_ID = '9020' OR a.SUPPLIER_ID = '9023' OR a.SUPPLIER_ID = '9034' OR a.SUPPLIER_ID = '9036' OR a.SUPPLIER_ID = '9093' OR a.SUPPLIER_ID = '9112' OR a.SUPPLIER_ID = '9142' OR a.SUPPLIER_ID = '9123' OR a.SUPPLIER_ID = '9130' OR a.SUPPLIER_ID = '9001' OR a.SUPPLIER_ID = '9136' OR a.SUPPLIER_ID = '9059' OR a.SUPPLIER_ID = '9096' OR a.SUPPLIER_ID = '9117' OR a.SUPPLIER_ID = '9108' OR a.SUPPLIER_ID = '9030' OR a.SUPPLIER_ID = '9056' OR a.SUPPLIER_ID = '9143' OR a.SUPPLIER_ID = '9129' OR a.SUPPLIER_ID = '9011' OR a.SUPPLIER_ID = '9116' OR a.SUPPLIER_ID = '9042' OR a.SUPPLIER_ID = '9064' OR a.SUPPLIER_ID = '9132' OR a.SUPPLIER_ID = '9126' OR a.SUPPLIER_ID = '9065' OR a.SUPPLIER_ID = '9106' OR a.SUPPLIER_ID = '9127' OR a.SUPPLIER_ID = '9025' OR a.SUPPLIER_ID = '9053' OR a.SUPPLIER_ID = '9134' OR a.SUPPLIER_ID = '9045' OR a.SUPPLIER_ID = '9085' OR a.SUPPLIER_ID = '9091' OR a.SUPPLIER_ID = '9122' OR a.SUPPLIER_ID = '9138' OR a.SUPPLIER_ID = '9024' OR a.SUPPLIER_ID = '9109' OR a.SUPPLIER_ID = '9070');
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000);   
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('SUPP_GRP', row_.SUPP_GRP, attr_);
      
      SUPPLIER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;