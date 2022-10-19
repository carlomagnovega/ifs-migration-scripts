DECLARE   
   CURSOR get_qaman IS
      SELECT b.objid,
             b.objversion,
             a.customer_id,
             a.ADDRESS_ID 
      FROM CUSTOMER_INFO_ADDRESS a
      inner join CUSTOMER_INFO_ADDRESS_TYPE b ON a.CUSTOMER_ID = b.CUSTOMER_ID AND b.ADDRESS_ID = a.ADDRESS_ID 
      WHERE b.ADDRESS_ID = 'MAIN'
      AND DEF_ADDRESS <> 'TRUE'
      AND a.customer_id > 7000;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DEF_ADDRESS', 'TRUE', attr_);
      CUSTOMER_INFO_ADDRESS_TYPE_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END;  

--------------------------Currecy_Code
DECLARE   
   CURSOR get_qaman IS
      SELECT   qcp.objid,
               qcp.objversion,
               c.def_currency,
               qcp.currency_code
      FROM CUST_ORD_CUSTOMER_ENT qcp
      INNER JOIN IDENTITY_INVOICE_INFO c ON qcp.customer_id = c.identity
      WHERE c.COMPANY = '40-UK'
      AND c.party_type_db = 'CUSTOMER'
      AND c.def_currency <> qcp.currency_code;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CURRENCY_CODE', row_.def_currency, attr_);
      
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
   END LOOP;   
END; 

-------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion
      FROM CUST_ORD_CUSTOMER_ENT qcp
      WHERE customer_id IN ('5300','5301','5302','5303','5304','5305','5306','5307','5308','5309','5310','5311','5312','5313','5314','5315','5316','5317','5318','5319','5320','5321','5322','5323','5324','5325','5326','5327','5329','5330','5331','5332','5333','5334','5335','5336','5337','5338','5339','5340','5341','5342','5343','5344','5345','5346','5347','5348','5349','5350','5351','5352','5353','5354','5355','5356','5357','5358','5359','5360','5361','5362','5363','5364','5365','5366','5367','5368','5369','5370','5371','5372','5373','5374','5375','5376','5377','5378','5379','5380','5381','5382','5383','5384','5385','5386','5387','5388','5389','5390','5391','5392','5393','5394','5395','5396','5397','5398','5399','5400','5401','5402','5403','5404','5405','5406','5407','5408','5409','5410','5411','5412','5413','5414','5415','5416','5417','5418','5419','5420','5421','5422','5423','5424','5425','5426','5427','5428','5429','5430','5431','5432','5433','5434','5435','5436','5437','5438','5439','5440','5441','5442','5443','5444','5445','5446','5447','5448','5449','5450','5451','5452','5453','5454','5455','5456','5457','5458','5459','5460','5461','5462','5463','5464','5465','5466','5467','5468','5469','5470','5471','5472','5473','5474','5475','5476','5477','5478','5479','5480','5481','5482','5483','5484','5485','5486','5487','5488','5489','5490','5491','5492','5493','5494','5495','5496','5497','5498','5499','5500','5501','5502','5503','5504','5505','5506','5507','5508','5509','5510','5511','5512','5513','5514','5515','5516','5517','5518','5519','5520','5521','5522','5523','5524','5525','5526','5527','5528','5529','5530','5531','5532','5533','5534','5535','5536','5537','5538','5539','5540','5541','5542','5543','5544','5545','5546','5547','5548','5549','5550','5551','5552','5553','5554','5555','5556','5557','5558','5559','5560','5561','5562','5563','5564','5565','5566','5567','5568','5569','5570','5571','5572','5573','5574','5575','5576','5577','5578','5579','5580','5581','5582','5583','5584','5585','5586','5587','5588','5589','5590','5591','5592','5593','5594','5595','5596','5597','5598','5599','5600','5601','5602','5603','5604','5605','5606','5607','5608','5609','5610','5611','5612','5613','5614','5615','5616','5617','5618','5619','5620','5621','5622','5623','5624','5625','5626','5627','5628','5629','5630','5631','5632','5633','5634','5635','5636','5637','5638','5639','5640','5641','5642','5643','5644','5645','5646','5647','5648','5649','5650','5651','5652','5653','5654','5655','5656','5657','5658','5659','5660','5661','5662','5663','5664','5665','5666','5667','5668','5669','5670','5671','5672','5673','5674','5675','5676','5677','5678','5679','5680','5681','5682','5683','5684','5685','5686','5687','5688','5689','5690','5691','5692','5693','5694','5695','5696','5697','5698','5699','5700','5701','5702','5703','5704','5705','5706','5707','5708','5709','5710','5711','5712','5713','5714','5715','5716','5717','5718','5719','5720','5721','5722','5723','5724','5725','5726','5727','5728','5729','5730','5731','5732','5733','5734','5735','5736','5737','5738','5739','5740','5741','5742','5743','5744','5745','5746','5747','5748','5749','5750','5751','5752','5753','5754','5755','5756','5757','5758','5759','5760','5761','5762','5763','5764','5765','5766','5767','5768','5769','5770','5771','5772','5773','5774','5775','5776','5777','5778','5779','5780','5781','5782','5783','5784','5785','5786','5787','5788','5789','5790','5791','5792','5793','5794','5795','5796','5797','5798','5799','5800','5801','5802','5803','5804','5805','5806','5807','5808','5809','5810','5811','5812','5813','5814','5815','5816','5817','5818','5819','5820','5821','5822','5823','5824','5825','5826','5827','5828','5829','5830','5831','5832','5833','5834','5835','5836','5837','5838','5839','5840','5841','5842','5843','5844','5845','5846','5847','5848','5849','5850','5851','5852','5853','5854','5855','5856','5857','5858','5859','5860','5861','5862','5863','5864','5865','5866','5867','5868','5869','5870','5871','5872','5873','5874','5875','5876','5877','5878','5879','5880','5881','5882','5883','5884','5885','5886','5887','5888','5889','5890','5891','5892','5893','5894','5895','5896','5897','5898','5899','5900','5901','5902','5903','5904','5905','5906','5907','5908','5909','5910','5911','5912','5913','5914','5915','5916','5917','5918','5919','5920','5921','5922','5923','5924','5925','5926','5927','5928','5929','5930','5931','5932','5933','5934','5935','5936','5937','5938','5939','5940','5941','5942','5943','5944','5945','5946','5947','5948','5949','5950','5951','5952','5953','5954','5955','5956','5957','5958','5959','5960','5961','5962','5963','5964','5965','5966','5967','5968','5969','5970','5971','5972','5973','5974','5975','5976','5977','5978','5979','5980','5981','5982','5983','5984','5985','5986','5987','5988')
      AND CUST_GRP = '*'; 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CUST_GRP', 'GENERAL', attr_);     
         
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');      
   END LOOP;   
END;

--------------------Payment Method
DECLARE   
   CURSOR get_qaman IS
      SELECT a.IDENTITY,
             a.COMPANY
      FROM IDENTITY_PAY_INFO a
      LEFT JOIN PAYMENT_WAY_PER_IDENTITY b ON a.IDENTITY = b.IDENTITY AND a.company = b.company AND a.PARTY_TYPE_DB = b.PARTY_TYPE_DB
      WHERE b.PARTY_TYPE_DB IS NULL
      AND a.COMPANY = '40-UK'
      AND a.party_type_db = 'CUSTOMER';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('IDENTITY', row_.IDENTITY, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE_DB', 'CUSTOMER', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', 'WIRE', attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', 'TRUE', attr_);
            
      PAYMENT_WAY_PER_IDENTITY_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
   END LOOP;   
END;

---------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  a.objid,
              a.objversion
      FROM CUST_ORD_CUSTOMER_ADDRESS_ENT a
      WHERE EXISTS (SELECT 1 
         FROM COMM_METHOD b
         WHERE PARTY_TYPE_DB = 'CUSTOMER' 
         AND b.IDENTITY = a.CUSTOMER_ID
         AND NAME = 'INVOICING')
      AND ADDRESS_ID = 'MAIN'
      AND customer_id IN ('5300','5301','5302','5303','5304','5305','5306','5307','5308','5309','5310','5311','5312','5313','5314','5315','5316','5317','5318','5319','5320','5321','5322','5323','5324','5325','5326','5327','5329','5330','5331','5332','5333','5334','5335','5336','5337','5338','5339','5340','5341','5342','5343','5344','5345','5346','5347','5348','5349','5350','5351','5352','5353','5354','5355','5356','5357','5358','5359','5360','5361','5362','5363','5364','5365','5366','5367','5368','5369','5370','5371','5372','5373','5374','5375','5376','5377','5378','5379','5380','5381','5382','5383','5384','5385','5386','5387','5388','5389','5390','5391','5392','5393','5394','5395','5396','5397','5398','5399','5400','5401','5402','5403','5404','5405','5406','5407','5408','5409','5410','5411','5412','5413','5414','5415','5416','5417','5418','5419','5420','5421','5422','5423','5424','5425','5426','5427','5428','5429','5430','5431','5432','5433','5434','5435','5436','5437','5438','5439','5440','5441','5442','5443','5444','5445','5446','5447','5448','5449','5450','5451','5452','5453','5454','5455','5456','5457','5458','5459','5460','5461','5462','5463','5464','5465','5466','5467','5468','5469','5470','5471','5472','5473','5474','5475','5476','5477','5478','5479','5480','5481','5482','5483','5484','5485','5486','5487','5488','5489','5490','5491','5492','5493','5494','5495','5496','5497','5498','5499','5500','5501','5502','5503','5504','5505','5506','5507','5508','5509','5510','5511','5512','5513','5514','5515','5516','5517','5518','5519','5520','5521','5522','5523','5524','5525','5526','5527','5528','5529','5530','5531','5532','5533','5534','5535','5536','5537','5538','5539','5540','5541','5542','5543','5544','5545','5546','5547','5548','5549','5550','5551','5552','5553','5554','5555','5556','5557','5558','5559','5560','5561','5562','5563','5564','5565','5566','5567','5568','5569','5570','5571','5572','5573','5574','5575','5576','5577','5578','5579','5580','5581','5582','5583','5584','5585','5586','5587','5588','5589','5590','5591','5592','5593','5594','5595','5596','5597','5598','5599','5600','5601','5602','5603','5604','5605','5606','5607','5608','5609','5610','5611','5612','5613','5614','5615','5616','5617','5618','5619','5620','5621','5622','5623','5624','5625','5626','5627','5628','5629','5630','5631','5632','5633','5634','5635','5636','5637','5638','5639','5640','5641','5642','5643','5644','5645','5646','5647','5648','5649','5650','5651','5652','5653','5654','5655','5656','5657','5658','5659','5660','5661','5662','5663','5664','5665','5666','5667','5668','5669','5670','5671','5672','5673','5674','5675','5676','5677','5678','5679','5680','5681','5682','5683','5684','5685','5686','5687','5688','5689','5690','5691','5692','5693','5694','5695','5696','5697','5698','5699','5700','5701','5702','5703','5704','5705','5706','5707','5708','5709','5710','5711','5712','5713','5714','5715','5716','5717','5718','5719','5720','5721','5722','5723','5724','5725','5726','5727','5728','5729','5730','5731','5732','5733','5734','5735','5736','5737','5738','5739','5740','5741','5742','5743','5744','5745','5746','5747','5748','5749','5750','5751','5752','5753','5754','5755','5756','5757','5758','5759','5760','5761','5762','5763','5764','5765','5766','5767','5768','5769','5770','5771','5772','5773','5774','5775','5776','5777','5778','5779','5780','5781','5782','5783','5784','5785','5786','5787','5788','5789','5790','5791','5792','5793','5794','5795','5796','5797','5798','5799','5800','5801','5802','5803','5804','5805','5806','5807','5808','5809','5810','5811','5812','5813','5814','5815','5816','5817','5818','5819','5820','5821','5822','5823','5824','5825','5826','5827','5828','5829','5830','5831','5832','5833','5834','5835','5836','5837','5838','5839','5840','5841','5842','5843','5844','5845','5846','5847','5848','5849','5850','5851','5852','5853','5854','5855','5856','5857','5858','5859','5860','5861','5862','5863','5864','5865','5866','5867','5868','5869','5870','5871','5872','5873','5874','5875','5876','5877','5878','5879','5880','5881','5882','5883','5884','5885','5886','5887','5888','5889','5890','5891','5892','5893','5894','5895','5896','5897','5898','5899','5900','5901','5902','5903','5904','5905','5906','5907','5908','5909','5910','5911','5912','5913','5914','5915','5916','5917','5918','5919','5920','5921','5922','5923','5924','5925','5926','5927','5928','5929','5930','5931','5932','5933','5934','5935','5936','5937','5938','5939','5940','5941','5942','5943','5944','5945','5946','5947','5948','5949','5950','5951','5952','5953','5954','5955','5956','5957','5958','5959','5960','5961','5962','5963','5964','5965','5966','5967','5968','5969','5970','5971','5972','5973','5974','5975','5976','5977','5978','5979','5980','5981','5982','5983','5984','5985','5986','5987','5988'); 
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CONTACT', 'INVOICING', attr_);   
      
      CUST_ORD_CUSTOMER_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');      
   END LOOP;   
END;

--------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  CUSTOMER_ID,
              ADDRESS_ID
      FROM CUSTOMER_INFO_ADDRESS a
      WHERE NOT EXISTS (SELECT 1 
         FROM CUSTOMER_TAX_INFO b
         WHERE PARTY_TYPE_DB = 'CUSTOMER' 
         AND b.company = '40-UK'
         AND b.CUSTOMER_ID = a.CUSTOMER_ID
         AND b.ADDRESS_ID = a.ADDRESS_ID)
      AND customer_id IN ('5301','5303','5304','5307','5313','5314','5315','5316','5323','5325','5332','5333','5334','5341','5344','5348','5350','5352','5362','5366','5371','5375','5383','5396','5397','5400','5401','5404','5408','5409','5410','5412','5413','5425','5432','5435','5448','5454','5456','5459','5467','5472','5478','5481','5493','5496','5502','5507','5517','5519','5521','5522','5523','5527','5533','5537','5539','5541','5542','5549','5550','5563','5564','5567','5573','5574','5578','5582','5585','5587','5588','5593','5599','5602','5617','5623','5629','5630','5639','5640','5644','5646','5656','5658','5660','5663','5664','5667','5669','5678','5679','5684','5687','5690','5692','5697','5700','5706','5712','5714','5716','5717','5719','5724','5726','5730','5731','5733','5735','5745','5751','5754','5764','5765','5771','5773','5774','5776','5779','5780','5781','5788','5789','5791','5793','5798','5810','5811','5814','5823','5825','5826','5830','5837','5848','5867','5875','5876','5877','5917','5921','5924','5927','5929','5938','5943','5944','5955','5966','5967','5972','5974','5977','5978','5981','5985','5986')
      GROUP BY CUSTOMER_ID, ADDRESS_ID; 
			  
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', '40-UK', attr_);
      Client_SYS.Add_To_Attr('CUSTOMER_ID', row_.CUSTOMER_ID, attr_);
      Client_SYS.Add_To_Attr('ADDRESS_ID', row_.ADDRESS_ID, attr_);
      Client_SYS.Add_To_Attr('TAX_REGIME', 'VAT', attr_);
      Client_SYS.Add_To_Attr('TAX_ROUNDING_METHOD', 'Round to the Nearest', attr_);
      Client_SYS.Add_To_Attr('TAX_WITHHOLDING', 'Blocked', attr_);
      Client_SYS.Add_To_Attr('TAX_ROUNDING_LEVEL', 'Specified on company', attr_);
      
      CUSTOMER_TAX_INFO_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
   END LOOP;   
END;
-------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             qcp.name
      FROM CUSTOMER_INFO a   
      INNER JOIN MTK_SUPPLIER_INFO_TAB qcp ON qcp.SUPPLIER_ID = a.SUPPLIER_ID;   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('NAME', row_.name, attr_);  
      
      CUSTOMER_INFO_GENERAL_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;
-------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid, 
             a.objversion,
             a.customer_id,
             qcp.COMPANY_NAME2 name
      FROM CUSTOMER_INFO_ADDRESS a   
      INNER JOIN MTK_CUSTOMER_INFO_ADDRESS_TAB qcp ON qcp.customer_id = a.customer_id AND qcp.address_id = a.address_id;   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('NAME', row_.name, attr_);  
      
      CUSTOMER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;


----------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid aobjid, 
            a.objversion aobjversion,
            a.customer_id ,
            a.name aname,
            qcp.objid bobjid, 
           qcp.objversion bobjversion,
           qcp.name bname
     FROM CUSTOMER_INFO a   
     INNER JOIN CUSTOMER_INFO_ADDRESS qcp ON qcp.customer_id = a.customer_id AND qcp.ADDRESS_ID = 'MAIN'
     WHERE a.customer_id > '7000' AND a.customer_id < '7800' AND qcp.name IS NOT NULL
     ORDER BY qcp.customer_id;   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.aobjid;
      objversion_ := row_.aobjversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('NAME', row_.bname, attr_);        
      CUSTOMER_INFO_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      
      objid_ := row_.bobjid;
      objversion_ := row_.bobjversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('NAME', row_.aname, attr_);        
      CUSTOMER_INFO_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      
      --COMMIT;
   END LOOP;   
END;
--------------------


DECLARE   
   CURSOR get_qaman IS
      SELECT  CUSTOMER_ID,
              ADDRESS_ID
      FROM CUSTOMER_INFO_ADDRESS a
      WHERE NOT EXISTS (SELECT 1 
         FROM CUSTOMER_TAX_INFO b
         WHERE PARTY_TYPE_DB = 'CUSTOMER' 
         AND b.company = '33-CX'
         AND b.CUSTOMER_ID = a.CUSTOMER_ID
         AND b.ADDRESS_ID = a.ADDRESS_ID)
      AND customer_id > '7000' AND customer_id < 7700
	  AND ADDRESS_ID = 'MAIN'
      GROUP BY CUSTOMER_ID, ADDRESS_ID; 
			  
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('CUSTOMER_ID', row_.CUSTOMER_ID, attr_);
      Client_SYS.Add_To_Attr('COMPANY', '33-CX', attr_);
      Client_SYS.Add_To_Attr('ADDRESS_ID', 'MAIN', attr_);
      Client_SYS.Add_To_Attr('TAX_WITHHOLDING', 'Blocked', attr_);
      Client_SYS.Add_To_Attr('TAX_ROUNDING_METHOD', 'Round to the Nearest', attr_);
      Client_SYS.Add_To_Attr('TAX_ROUNDING_LEVEL', 'Specified on company', attr_);
      Client_SYS.Add_To_Attr('INV_VOU_DATE_BASE', 'Specified on company', attr_);
      Client_SYS.Add_To_Attr('INV_CURR_RATE_BASE', 'Specified on company', attr_);
      Client_SYS.Add_To_Attr('TAX_RATE_DATE', 'Specified on company', attr_);	  
      Client_SYS.Add_To_Attr('EXC_FROM_SPESOMETRO_DEC', 'FALSE', attr_);
	        
      CUSTOMER_TAX_INFO_API.NEW__( info_ , objid_ , objversion_ , attr_, 'DO' );
   END LOOP;   
END;

---------------IND
DROP TABLE MTK_CUST_ORD_CUSTOMER_TAB;

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   DELIVERY_TERMS                    VARCHAR2(50)        NOT NULL,
   SHIP_VIA_CODE                     VARCHAR2(20)         NOT NULL,
   MARKET_CODE                       VARCHAR2(35)        NULL,
   WAY_ID                           VARCHAR2(35)        NULL
);
-------------------
SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID, DELIVERY_TERMS, SHIP_VIA_CODE, MARKET_CODE, WAY_ID) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [DELIVERY_TERMS]
		+ ''',''' + [SHIP_VIA_CODE]
		+ ''',''' + [MARKET_CODE]
		+ ''',''' + [WAY_ID]
		+  ''');'   aa
FROM ( SELECT convert(varchar, [IFS Custoemr ID]) [CUSTOMER_NO]
			  ,[Delivery Terms] [DELIVERY_TERMS]     			  
			  ,[Ship Via] [SHIP_VIA_CODE]    
			  ,[Market code] [MARKET_CODE]    
			  ,[Payment Method] [WAY_ID]      
	  FROM [IFSDEV-ManualUpload].[dbo].['Customers-IND$']) aaa   
-----------------------------

CREATE TABLE MTK_CUST_ORD_CUSTOMER_TAB
(
   CUSTOMER_ID                        VARCHAR2(20)        NOT NULL,
   MARKET_CODE                       VARCHAR2(35)        NULL,
   SALESMAN_CODE                      VARCHAR2(20)    NULL
);

SELECT 'INSERT INTO MTK_CUST_ORD_CUSTOMER_TAB (CUSTOMER_ID, MARKET_CODE, SALESMAN_CODE) VALUES (''' 
		+ [CUSTOMER_NO]
		+ ''',''' + [Market_Code]
		+ ''',''' + [Salesman_Code]
		+  ''');'   aa
FROM ( SELECT convert(varchar, [Identity]) [CUSTOMER_NO]
			  ,[Market_Code]
      ,convert(varchar,[Salesman_Code])      [Salesman_Code]
	  FROM [IFSDEV-ManualUpload].[dbo].[CustomerInfoCX$]) aaa  


-----------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              qcpa.DELIVERY_TERMS,
              qcpa.SHIP_VIA_CODE
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER_ADDRESS qcp ON qcp.customer_no  = qcpa.CUSTOMER_ID AND qcp.addr_no  = 'MAIN';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('DELIVERY_TERMS', row_.DELIVERY_TERMS, attr_);
      Client_SYS.Add_To_Attr('SHIP_VIA_CODE', row_.SHIP_VIA_CODE, attr_);
	  
      CUST_ORD_CUSTOMER_ADDRESS_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

-------	  
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              trim(qcpa.MARKET_CODE) MARKET_CODE
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER qcp ON qcp.customer_no  = qcpa.CUSTOMER_ID
      WHERE qcpa.MARKET_CODE <> 'SPEC-RD';
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('MARKET_CODE', row_.MARKET_CODE, attr_);
	  
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

------------------------------------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT  qcp.objid,
              qcp.objversion,
              trim(qcpa.MARKET_CODE) MARKET_CODE,
              qcpa.SALESMAN_CODE
      FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
      INNER JOIN CUST_ORD_CUSTOMER qcp ON qcp.customer_no  = qcpa.CUSTOMER_ID;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      objid_ := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('MARKET_CODE', row_.MARKET_CODE, attr_);
      Client_SYS.Add_To_Attr('SALESMAN_CODE', row_.SALESMAN_CODE, attr_);
      
      CUST_ORD_CUSTOMER_API.MODIFY__(info_, objid_, objversion_, attr_, 'DO');
      --COMMIT;
   END LOOP;   
END;

------------------
DECLARE   
   CURSOR get_qaman IS
		SELECT  '32-IND' COMPANY,
			qcpa.CUSTOMER_ID,
			qcpa.WAY_ID
		FROM MTK_CUST_ORD_CUSTOMER_TAB qcpa
		LEFT JOIN PAYMENT_WAY_PER_IDENTITY qcp ON 
		qcp.IDENTITY  = qcpa.CUSTOMER_ID 
		AND qcp.COMPANY  = '32-IND'
		AND qcp.PARTY_TYPE_DB  = 'CUSTOMER'
		AND qcp.WAY_ID  = qcpa.WAY_ID
      WHERE qcp.WAY_ID IS NULL
      ORDER BY qcpa.CUSTOMER_ID;
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_                VARCHAR2(26000); 
BEGIN   
   FOR row_ IN get_qaman LOOP
      
      Client_SYS.Clear_Attr(attr_);
      Client_SYS.Add_To_Attr('COMPANY', row_.COMPANY, attr_);
      Client_SYS.Add_To_Attr('IDENTITY', row_.CUSTOMER_ID, attr_);
      Client_SYS.Add_To_Attr('PARTY_TYPE_DB', 'CUSTOMER', attr_);
      Client_SYS.Add_To_Attr('WAY_ID', row_.WAY_ID, attr_);
      Client_SYS.Add_To_Attr('DEFAULT_PAYMENT_WAY', 'TRUE', attr_);
	  
      PAYMENT_WAY_PER_IDENTITY_API.NEW__(info_, objid_, objversion_, attr_, 'DO');
      COMMIT;
   END LOOP;   
END;

