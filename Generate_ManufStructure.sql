--------Extract existing ones
SELECT   PART_NO,
         CONTRACT,
         ALTERNATIVE_NO,
         LINE_ITEM_NO,
         COMPONENT_PART,
         QTY_PER_ASSEMBLY
FROM MANUF_STRUCTURE
WHERE CONTRACT = '33CX' and (PART_NO = '8152' or PART_NO = '8219' or PART_NO = '22539' or PART_NO = '22545' or PART_NO = '22558' or PART_NO = '22584' or PART_NO = '22654' or PART_NO = '51609' or PART_NO = '51670' or PART_NO = '53153' or PART_NO = '89065' or PART_NO = '89333' or PART_NO = '89375' or PART_NO = '89453' or PART_NO = '89522' or PART_NO = '1005-01-BULK' or PART_NO = '1005-03-BULK' or PART_NO = '1005-06-BULK' or PART_NO = '1006-01-BULK' or PART_NO = '1006-03-BULK' or PART_NO = '1006-07-BULK' or PART_NO = '1006-07-CFTI-BULK' or PART_NO = '1006-09-BULK' or PART_NO = '1012-07-BULK' or PART_NO = '1014-07-BULK' or PART_NO = '105-BULK' or PART_NO = '1064-01-BULK' or PART_NO = '1065-01-BULK' or PART_NO = '1065-07-BULK' or PART_NO = '1065-12-BULK' or PART_NO = '1066-01-BULK' or PART_NO = '1066-07-BULK' or PART_NO = '1066-12-BULK' or PART_NO = '1066-28-BULK' or PART_NO = '1072-07-BULK' or PART_NO = '110-BULK' or PART_NO = '1138-01-BULK' or PART_NO = '1138-07-BULK' or PART_NO = '114-BULK' or PART_NO = '1151-01-BULK' or PART_NO = '1151-07-BULK' or PART_NO = '1158-18-BULK' or PART_NO = '1162-27-BULK' or PART_NO = '116-BULK' or PART_NO = '1192-27-BULK' or PART_NO = '1193-27-BULK' or PART_NO = '119-BULK' or PART_NO = '1200-07-BULK' or PART_NO = '12013-AIM20EAKG' or PART_NO = '12013-S223-AIM20EAKG' or PART_NO = '1233-07-BULK' or PART_NO = '1234-10-BULK' or PART_NO = '1234-12-BULK' or PART_NO = '1260-05-BULK' or PART_NO = '1277-13-BULK' or PART_NO = '1278-13-BULK' or PART_NO = '1279-13-BULK' or PART_NO = '1280-13-BULK' or PART_NO = '13090-AIM20EAKG' or PART_NO = '1359-05-BULK' or PART_NO = '135-BULK' or PART_NO = '1373-18-BULK' or PART_NO = '13810-AIM40EAKG' or PART_NO = '13818-AIM40EAKG' or PART_NO = '14096-AIM20EAKG' or PART_NO = '14096-S199-AIM20EAKG' or PART_NO = '14126-AIM20EAKG' or PART_NO = '14126-S198-AIM20EAKG' or PART_NO = '14126-S199-AIM20EAKG' or PART_NO = '14178-AIM20EAKG' or PART_NO = '14178-S199-AIM20EAKG' or PART_NO = '14178-S202-AIM20EAKG' or PART_NO = '14178-S215-AIM20EAKG' or PART_NO = '14178-S225-AIM20EAKG' or PART_NO = '14178-S97-AIM20EAKG' or PART_NO = '14195-AIM20EAKG' or PART_NO = '14195-S50-AIM20EAKG' or PART_NO = '14254-AIM20EAKG' or PART_NO = '14255-AIM20EAKG' or PART_NO = '14354-AIM20EAKG' or PART_NO = '14407-AIM20EAKG' or PART_NO = '14440-AIM20EAKG' or PART_NO = '14440-S199-AIM20EAKG' or PART_NO = '15023-AIM20EAKG' or PART_NO = '15023-S199-AIM20EAKG' or PART_NO = '15119-AIM20EAKG' or PART_NO = '15119-S199-AIM20EAKG' or PART_NO = '15349-AIM20EAKG' or PART_NO = '15349-S212-AIM20EAKG' or PART_NO = '15539-AIM20EAKG' or PART_NO = '15570-AIM20EAKG' or PART_NO = '15570-S212-AIM20EAKG' or PART_NO = '15573-AIM20EAKG' or PART_NO = '15573-S210-AIM20EAKG' or PART_NO = '15627-AIM20EAKG' or PART_NO = '15654-AIM20EAKG' or PART_NO = '15682-AIM20EAKG' or PART_NO = '15683-AIM20EAKG' or PART_NO = '15686-AIM20EAKG' or PART_NO = '15688-AIM20EAKG' or PART_NO = '15689-AIM20EAKG' or PART_NO = '15690-AIM20EAKG' or PART_NO = '15690-S207-AIM20EAKG' or PART_NO = '1572-07-BULK' or PART_NO = '15720-AIM20EAKG' or PART_NO = '1573-01-BULK' or PART_NO = '1573-06-BULK' or PART_NO = '1573-12-BULK' or PART_NO = '1574-06-BULK' or PART_NO = '15765-AIM20EAKG' or PART_NO = '15797-AIM20EAKG' or PART_NO = '15799-AIM20EAKG' or PART_NO = '15810-AIM20EAKG' or PART_NO = '15826-AIM20EAKG' or PART_NO = '15826-S198-AIM20EAKG' or PART_NO = '15847-AIM40EAKG' or PART_NO = '15862-AIM20EAKG' or PART_NO = '15886-AIM20EA' or PART_NO = '15997-AIM20EAKG' or PART_NO = '16031-AIM20EAKG' or PART_NO = '16032-AIM10EAKG' or PART_NO = '16032-S237-AIM10EAKG' or PART_NO = '16037-AIM20EAKG' or PART_NO = '16038-AIM20EAKG' or PART_NO = '16039-AIM20EAKG' or PART_NO = '16040-S203-AIM10EAKG' or PART_NO = '1607-07-BULK' or PART_NO = '1608-07-BULK' or PART_NO = '1614-05-BULK' or PART_NO = '1621-07-BULK' or PART_NO = '1687-07-BULK' or PART_NO = '1688-07-BULK' or PART_NO = '1691-07-BULK' or PART_NO = '1707-02-BULK' or PART_NO = '1707-27-BULK' or PART_NO = '1707-28-BULK' or PART_NO = '1707-37-BULK' or PART_NO = '1709-02-BULK' or PART_NO = '1709-03-BULK' or PART_NO = '1709-27-BULK' or PART_NO = '1709-28-BULK' or PART_NO = '1709-37-BULK' or PART_NO = '1710-29-BULK' or PART_NO = '1711-01-BULK' or PART_NO = '1712-07-BULK' or PART_NO = '1713-27-BULK' or PART_NO = '1714-44-50-BULK' or PART_NO = '1715-27-BULK' or PART_NO = '1715-28-BULK' or PART_NO = '1716-27-BULK' or PART_NO = '1717-04-BULK' or PART_NO = '1717-43-BULK' or PART_NO = '1718-28-BULK' or PART_NO = '1720-27-BULK' or PART_NO = '1721-07-BULK' or PART_NO = '1721-27-BULK' or PART_NO = '1721-30-BULK' or PART_NO = '17314-AIM40EAKG' or PART_NO = '17316KG' or PART_NO = '17332-05-00' or PART_NO = '17337-AIM20EAKG' or PART_NO = '17337-S209-AIM20EAKG' or PART_NO = '17337-S221-AIM20EAKG' or PART_NO = '17383-AIM20EAKG' or PART_NO = '17383-S212-AIM20EAKG' or PART_NO = '17439-AIM20EAKG' or PART_NO = '18127-S199-AIM20EAKG' or PART_NO = '21015-01-00' or PART_NO = '21049-07-00' or PART_NO = '21049-07-00-ACT' or PART_NO = '21049-07-00-SHJ' or PART_NO = '21049-07-00-SZM' or PART_NO = '21077-12-00' or PART_NO = '21168-07-00' or PART_NO = '21169-07-00' or PART_NO = '21178-07-00' or PART_NO = '21178-12-00' or PART_NO = '21178-12-00-AHK' or PART_NO = '21178-12-00-INV' or PART_NO = '21178-12-00-KOS' or PART_NO = '21371-07-00' or PART_NO = '21390-01-00' or PART_NO = '21602-07-00' or PART_NO = '21602-07-46-SJK' or PART_NO = '22106-07-00' or PART_NO = '22106-12-00' or PART_NO = '22106-12-00-APT' or PART_NO = '22408-07-00' or PART_NO = '22505-ASA' or PART_NO = '22654-PLX' or PART_NO = '22730-01-00' or PART_NO = '22759-07-00' or PART_NO = '22777-18-00' or PART_NO = '22806-01-00' or PART_NO = '22849-01-00' or PART_NO = '22928-01-00' or PART_NO = '22928-28-00' or PART_NO = '22990-07-00' or PART_NO = '4715-AIM20EA' or PART_NO = '50037D-S44KG' or PART_NO = '50037E-S2KG' or PART_NO = '50037F-S2KG' or PART_NO = '50046KG' or PART_NO = '50046-S35KG' or PART_NO = '52193-AIM20EAKG' or PART_NO = '52215-AIM20EAKG' or PART_NO = '52222-S78-PAILKG' or PART_NO = '52223-S78-PAILKG' or PART_NO = '52224-AIM20EAKG' or PART_NO = '52224-S210-AIM20EAKG' or PART_NO = '52289-S2KG' or PART_NO = '52308KG' or PART_NO = '52308-S35KG' or PART_NO = '52308-S50KG' or PART_NO = '52362-S78-AIM20EAKG' or PART_NO = '52374-AIM20EAKG' or PART_NO = '52374-S199-AIM20EAKG' or PART_NO = '52391-S199-AIM20EAKG' or PART_NO = '52477-AIM20EAKG' or PART_NO = '52481-S78-PAILKG' or PART_NO = '52482-S78-PAILKG' or PART_NO = '52501-AIM4EAKG' or PART_NO = '52501-S207-AIM4EAKG' or PART_NO = '52510-AIM20EAKG' or PART_NO = '52525-S78-PAILKG' or PART_NO = '52539-AIM20EAKG' or PART_NO = '52554-EAKG' or PART_NO = '52554-S201EAKG' or PART_NO = '52563-AIM20EAKG' or PART_NO = '52579-AIM20EAKG' or PART_NO = '52603-AIM40EAKG' or PART_NO = '52603-S144-AIM40EAKG' or PART_NO = '52657-S78-AIM20EAKG' or PART_NO = '52663-S208-AIM8EAKG' or PART_NO = '52667-AIM8EAKG' or PART_NO = '52667-S35-AIM8EAKG' or PART_NO = '52670-S208-AIM8EAKG' or PART_NO = '52674-AIM20EAKG' or PART_NO = '52677-AIM20EAKG' or PART_NO = '52689-S43-PAIL' or PART_NO = '52691-AIM20EAKG' or PART_NO = '52696-AIM20EAKG' or PART_NO = '52699-AIM20EAKG' or PART_NO = '52699-S215-AIM20EAKG' or PART_NO = '52702-S197-AIM20EAKG' or PART_NO = '52737-AIM4EAKG' or PART_NO = '52754-AIM20EAKG' or PART_NO = '52755-AIM20EAKG' or PART_NO = '52755-S144-AIM20EAKG' or PART_NO = '52759-AIM20EAKG' or PART_NO = '52759-S144-AIM20EAKG' or PART_NO = '52766-AIM10EAKG' or PART_NO = '52766-S144-AIM10EAKG' or PART_NO = '52770-AIM20EAKG' or PART_NO = '52770-S144-AIM20EAKG' or PART_NO = '52783-S197-AIM20EAKG' or PART_NO = '52786-S10KG' or PART_NO = '52792-AIM20EAKG' or PART_NO = '52792-S10-AIM20EAKG' or PART_NO = '52797-S10-AIM20EAKG' or PART_NO = '52816-AIM20EAKG' or PART_NO = '52823-AIM20EAKG' or PART_NO = '52823-S10-AIM20EAKG' or PART_NO = '52839-AIM20EAKG' or PART_NO = '52839-S209-AIM20EAKG' or PART_NO = '52845-AIM20EAKG' or PART_NO = '52868KG' or PART_NO = '52908-S97-AIM20EAKG' or PART_NO = '52910-S97-AIM20EAKG' or PART_NO = '52919-S2KG' or PART_NO = '52922-AIM20EAKG' or PART_NO = '52946-AIM20EAKG' or PART_NO = '52960-AIM20EAKG' or PART_NO = '52995-AIM20EAKG' or PART_NO = '52995-S50-AIM20EAKG' or PART_NO = '52998-S130-AIM1EAKG' or PART_NO = '53010-AIM20EAKG' or PART_NO = '53015-S50KG' or PART_NO = '53021-AIM10EAKG' or PART_NO = '53026-AIM10EAKG' or PART_NO = '53029-AIM10EAKG' or PART_NO = '53032-S78-AIM20EAKG' or PART_NO = '53033-AIM10EAKG' or PART_NO = '53037-AIM10EAKG' or PART_NO = '53041-AIM20EAKG' or PART_NO = '53041-S237-AIM10EAKG' or PART_NO = '53046-AIM20EAKG' or PART_NO = '53048-AIM20EAKG' or PART_NO = '53049-AIM40EAKG' or PART_NO = '53053-AIM20EAKG' or PART_NO = '53053-S221-AIM20EAKG' or PART_NO = '53055-AIM20EAKG' or PART_NO = '53056-AIM20EAKG' or PART_NO = '53056-S221-AIM20EAKG' or PART_NO = '53061-AIM20EAKG' or PART_NO = '53062-AIM20EAKG' or PART_NO = '53062-S10-AIM20EAKG' or PART_NO = '53075-AIM20EAKG' or PART_NO = '53078-AIM20EAKG' or PART_NO = '53079-AIM20EAKG' or PART_NO = '53090-AIM20EAKG' or PART_NO = '53093-AIM20EAKG' or PART_NO = '53094-AIM20EAKG' or PART_NO = '53095-AIM40EAKG' or PART_NO = '53099-07-00' or PART_NO = '53102-AIM40EAKG' or PART_NO = '53104-AIM20EAKG' or PART_NO = '53106-AIM20EAKG' or PART_NO = '53107-AIM8EAKG' or PART_NO = '53110-AIM20EAKG' or PART_NO = '53113-AIM20EAKG' or PART_NO = '53119-AIM20EAKG' or PART_NO = '53121-S237-AIM10EAKG' or PART_NO = '53122-AIM20EAKG' or PART_NO = '53125-AIM40EAKG' or PART_NO = '53127-AIM20EAKG' or PART_NO = '53131-AIM20EAKG' or PART_NO = '53132-AIM20EAKG' or PART_NO = '53132-S203-AIM20EAKG' or PART_NO = '53132-S209-AIM20EAKG' or PART_NO = '53134-07-00' or PART_NO = '53137-AIM20EAKG' or PART_NO = '53138-AIM20EAKG' or PART_NO = '53139-20-00' or PART_NO = '53141-AIM20EAKG' or PART_NO = '53144-AIM10EAKG' or PART_NO = '53155-AIM40EAKG' or PART_NO = '53167-09-34' or PART_NO = '53167-13-34' or PART_NO = '53169-AIM20EAKG' or PART_NO = '53175-05-34' or PART_NO = '53176-AIM20EAKG' or PART_NO = '53183-S221-AIM20EAKG' or PART_NO = '53186-AIM20EAKG' or PART_NO = '53188-28-00' or PART_NO = '53188-29-00' or PART_NO = '53191-AIM4EAKG' or PART_NO = '53201-01-00' or PART_NO = '53202-02-00' or PART_NO = '53202-03-00' or PART_NO = '53202-27-00' or PART_NO = '53202-28-00' or PART_NO = '53202-37-00' or PART_NO = '53203-02-00' or PART_NO = '53203-27-00' or PART_NO = '53203-28-00' or PART_NO = '53203-37-00' or PART_NO = '53300-07-34' or PART_NO = '53322-27-00' or PART_NO = '53329-28-00' or PART_NO = '53330-28-00' or PART_NO = '53333-27-00' or PART_NO = '53343-43-00' or PART_NO = '53345-27-00' or PART_NO = '53346-30-00' or PART_NO = '53348-27-00' or PART_NO = '53357-03-00' or PART_NO = '53359-07-00' or PART_NO = '53363-12-00' or PART_NO = '53394-02-00' or PART_NO = '53394-03-00' or PART_NO = '53394-27-00' or PART_NO = '55887-AIM20EAKG' or PART_NO = '55890-AIM20EAKG' or PART_NO = '55890-S97-AIM20EAKG' or PART_NO = '5717-S2KG' or PART_NO = '58001E-S2KG' or PART_NO = '58031KG' or PART_NO = '5961-S43KG' or PART_NO = '60001C-S44KG' or PART_NO = '60001E-S2KG' or PART_NO = '60001-S2KG' or PART_NO = '60001S-S2KG' or PART_NO = '60001W-S2KG' or PART_NO = '60004-S2KG' or PART_NO = '60004S-S2KG' or PART_NO = '60004W-S2KG' or PART_NO = '60005W-S2KG' or PART_NO = '60006-S2KG' or PART_NO = '60006W-S2KG' or PART_NO = '60007W-S2KG' or PART_NO = '60008-S2KG' or PART_NO = '60009-S2KG' or PART_NO = '60013-S2KG' or PART_NO = '60013-S92KG' or PART_NO = '60014-S2KG' or PART_NO = '60014W-S2KG' or PART_NO = '60015-S2KG' or PART_NO = '60017-S2KG' or PART_NO = '60017W-S2KG' or PART_NO = '60020-S2KG' or PART_NO = '60020-S92KG' or PART_NO = '60020W-S2KG' or PART_NO = '60025-S2KG' or PART_NO = '60033-S2KG' or PART_NO = '60038W-S2KG' or PART_NO = '60039-S2KG' or PART_NO = '60039W-S2KG' or PART_NO = '60055-S2KG' or PART_NO = '60055W-S2KG' or PART_NO = '60068-S2KG' or PART_NO = '60068W-S2KG' or PART_NO = '60069-S2KG' or PART_NO = '60069W-S2KG' or PART_NO = '61003KG' or PART_NO = '61005KG' or PART_NO = '61006KG' or PART_NO = '61008KG' or PART_NO = '61011KG' or PART_NO = '61013KG' or PART_NO = '61016KG' or PART_NO = '61019KG' or PART_NO = '61023KG' or PART_NO = '61028KG' or PART_NO = '79545KG' or PART_NO = '79650KG' or PART_NO = '79651KG' or PART_NO = '79652KG' or PART_NO = '79661KG' or PART_NO = '79687KG' or PART_NO = '79733KG' or PART_NO = '79809KG' or PART_NO = '79828KG' or PART_NO = '79831KG' or PART_NO = '79834KG' or PART_NO = '79911KG' or PART_NO = '79929KG' or PART_NO = '79932KG' or PART_NO = '79935KG' or PART_NO = '79937KG' or PART_NO = '79969KG' or PART_NO = '79996KG' or PART_NO = '83028KG' or PART_NO = '83037KG' or PART_NO = '83044KG' or PART_NO = '83045KG' or PART_NO = '83064KG' or PART_NO = '83108KG' or PART_NO = '83119KG' or PART_NO = '83119-S50KG' or PART_NO = '83120-S2KG' or PART_NO = '83152KG' or PART_NO = '83153KG' or PART_NO = '83155KG' or PART_NO = '83156KG' or PART_NO = '83157KG' or PART_NO = '83164KG' or PART_NO = '83198KG' or PART_NO = '83207KG' or PART_NO = '84326KG' or PART_NO = '84327KG' or PART_NO = '84478-S50KG' or PART_NO = '85058-S2KG' or PART_NO = '85086-S50KG' or PART_NO = '89079-27-00' or PART_NO = '89130-18-00-SZM' or PART_NO = '89160-01-01' or PART_NO = '89163-01-00' or PART_NO = '89172-13-00' or PART_NO = '89173-13-00' or PART_NO = '89173-13-00-LTF' or PART_NO = '89180-05-14' or PART_NO = '89181-13-00' or PART_NO = '89185-13-00' or PART_NO = '89204-05-00-AHK' or PART_NO = '89208-20-00' or PART_NO = '89208-20-00-AHK' or PART_NO = '89208-23-00' or PART_NO = '89268-07-00' or PART_NO = '89268-07-00-BSC' or PART_NO = '89268-07-00-OSR' or PART_NO = '89268-07-00-SHJ' or PART_NO = '89268-07-48-APS' or PART_NO = '89287-03-00' or PART_NO = '89288-05-00' or PART_NO = '89315-07-00' or PART_NO = '89320-27-00' or PART_NO = '89331-01-00' or PART_NO = '89331-03-00' or PART_NO = '89356-01-00' or PART_NO = '89356-03-00' or PART_NO = '89395-07-00' or PART_NO = '89396-05-00' or PART_NO = '89414-28-00-AHK' or PART_NO = '89444-07-00' or PART_NO = '89460-07-00' or PART_NO = '89465-07-00' or PART_NO = '89476-07-00' or PART_NO = '89484-07-00' or PART_NO = '89485-07-00' or PART_NO = '89538-07-00' or PART_NO = '89547-01-00' or PART_NO = '89587-01-00' or PART_NO = '89600-27-00-AHK' or PART_NO = '89623-05-00' or PART_NO = '89623-28-00-AHK' or PART_NO = '89646-03-00' or PART_NO = '89646-05-26' or PART_NO = '89646-05-26-SAO' or PART_NO = '89646-28-00' or PART_NO = '89646-28-00-TSM' or PART_NO = '89665-07-00' or PART_NO = '89666-07-31' or PART_NO = '89673-07-00' or PART_NO = '89675-05-34' or PART_NO = '89690-05-41-LUX' or PART_NO = 'BILLET' or PART_NO = 'INV PASTE TRANSFER' or PART_NO = 'INV PASTE TRANSFER 500G' or PART_NO = 'KIT-00-JAR-NC-L' or PART_NO = 'KIT-00-JAR-NC-ORANGE' or PART_NO = 'KIT-00-S10-EPOXY-S' or PART_NO = 'KIT-00-S10-EPOXY-S-PLX' or PART_NO = 'KIT-00-S10-NC-S' or PART_NO = 'KIT-00-S10-NC-S-PLX' or PART_NO = 'KIT-00-S30-EPOXY-M' or PART_NO = 'KIT-00-S30-NC-M' or PART_NO = 'KIT-00-S30-NC-M-PLX' or PART_NO = 'KIT-00-S30-RO-M' or PART_NO = 'KIT-00-S30-WS-M' or PART_NO = 'KIT-LF-C06-NC-M' or PART_NO = 'KIT-LF-C12-NC-L' or PART_NO = 'KIT-LF-JAR-NC-L' or PART_NO = 'KIT-LF-JAR-RO-L' or PART_NO = 'KIT-LF-JAR-WS-L' or PART_NO = 'KIT-LF-S05-NC-S' or PART_NO = 'KIT-LF-S05-RO-S' or PART_NO = 'KIT-LF-S10-NC-S' or PART_NO = 'KIT-LF-S10-WS-S' or PART_NO = 'KIT-LF-S30-NC-M' or PART_NO = 'REMELT' or PART_NO = 'SPOOL' or PART_NO = 'VRAC' or PART_NO = 'VRACOUTMANUAL')


---------------------Delete some PROD_STRUCTURE
UPDATE manuf_struct_alternate_tab PST
SET ROWSTATE = 'Tentative'
WHERE EXISTS (SELECT 1 
                     FROM MTK_MANUF_STRUCT_ALTERNATE_TAB MST 
                     where MST.CONTRACT = PST.CONTRACT  AND MST.PART_NO = PST.PART_NO);
	
----------------------------------------	
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion
      FROM PROD_STRUCTURE a
      WHERE EXISTS (SELECT 1 FROM  MTK_MANUF_STRUCT_ALTERNATE_TAB b where a.Contract = b.Contract AND a.Part_No = b.Part_No);   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      PROD_STRUCTURE_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;	

---------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion,
             a.Contract, 
             a.Part_No
      FROM PROD_STRUCTURE_HEAD a
      WHERE EXISTS (SELECT 1 
                     FROM MTK_MANUF_STRUCT_ALTERNATE_TAB b 
                     WHERE a.Contract = b.Contract AND a.Part_No = b.Part_No);
   
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      PROD_STRUCTURE_HEAD_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;

--------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT a.objid,  
             a.objversion,
             a.Contract, 
             a.Part_No,
             a.eng_chg_level,
             a.bom_type
      FROM PROD_STRUCTURE a
      WHERE a.Contract = '33CX';  
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      
      PROD_STRUCTURE_API.REMOVE__( info_ , objid_ , objversion_ , 'DO' );
      COMMIT;      
   END LOOP;   
END;

				 

------------------------------Generate
------------------------------Generate
SET NOCOUNT ON;    
DECLARE @COMPONENT_PART VARCHAR(80), 
		@PART_NO VARCHAR(80),  
		@PART_AUX VARCHAR(80),  
		@LINE_ITEM_NO VARCHAR(80), 
		@QTY_PER_ASSEMBLY VARCHAR(50),
		@LINE_ITEM INT,
		@ALTERNATIVE_NO VARCHAR(50);

DECLARE vendor_cursor CURSOR FOR   
/*SELECT  [COMPONENT_PART]
	  ,[PART_NO]
	  ,[ALTERNATIVE_NO]
      ,max(ISNULL([LINE_ITEM_NO], '0')) [LINE_ITEM_NO]
      ,max([QTY_PER_ASSEMBLY]) [QTY_PER_ASSEMBLY]      
  FROM [IFSDEV-ManualUpload].[dbo].[ManufStructureCN$]
  WHERE [PART_NO] IS NOT NULL
  GROUP BY [PART_NO],[ALTERNATIVE_NO],[COMPONENT_PART]
  ORDER BY [PART_NO],[ALTERNATIVE_NO],[COMPONENT_PART];*/
  SELECT [Component_Part] [COMPONENT_PART]
	  ,[IFS CODES] [PART_NO]
	  ,'*' [ALTERNATIVE_NO]
      ,max(ISNULL([Line_Sequence], '0')) [LINE_ITEM_NO]
      ,max([Qty_Per_Assembly]) [QTY_PER_ASSEMBLY]      
  FROM [IFSDEV-ManualUpload].[dbo].[ManufStructureCXPaste$]
  WHERE [IFS CODES] IS NOT NULL
  GROUP BY [IFS CODES],[Component_Part]
  ORDER BY [IFS CODES],[Component_Part];
	
truncate table [dbo].[ManufStructure];

OPEN vendor_cursor    
FETCH NEXT FROM vendor_cursor   
INTO  @COMPONENT_PART, @PART_NO, @ALTERNATIVE_NO, @LINE_ITEM_NO,	@QTY_PER_ASSEMBLY;
  
SET @LINE_ITEM = 0;
SET @PART_AUX = '';
WHILE @@FETCH_STATUS = 0  
BEGIN  
	IF (@PART_AUX <> @PART_NO) AND (@ALTERNATIVE_NO <> @ALTERNATIVE_NO)
	BEGIN
		SET @LINE_ITEM = 0;
	END
	SET @LINE_ITEM = @LINE_ITEM + 10;
	SET @PART_AUX = @PART_NO;

    INSERT INTO [dbo].[ManufStructure]
           ([COMPONENT_PART]
           ,[PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[LINE_ITEM_NO]
           ,[COMPONENT_CONTRACT]
           ,[EFF_PHASE_IN_DATE]
           ,[EFF_PHASE_OUT_DATE]
           ,[QTY_PER_ASSEMBLY]
           ,[SHRINKAGE_FACTOR]
           ,[OPERATION_NO]
           ,[CREATE_DATE]
           ,[LAST_ACTIVITY_DATE]
           ,[CONSUMPTION_ITEM]
           ,[COMPONENT_SCRAP]
           ,[MTK_MODE]
           ,[ISSUE_TO_LOC]
           ,[DRAW_POS_NO]
           ,[STD_PLANNED_ITEM]
           ,[NOTE_TEXT]
           ,[PHANTOM_CONSUME_DB]
           ,[PROCEDURE_STEP])
	VALUES (@COMPONENT_PART
		  ,@PART_NO
		  ,'33CX'
		  ,''
		  ,'1'
		  ,@ALTERNATIVE_NO
		  ,'M'
		  ,@LINE_ITEM
		  ,'33CX'
		  ,'01/01/2010'
		  ,'01/01/2010'
		  ,@QTY_PER_ASSEMBLY
		  ,''
		  ,''
		  ,'01/01/2010'
		  ,'01/01/2010'
		  ,'Consumed'
		  ,''
		  ,'*'
		  ,''
		  ,''
		  ,''
		  ,''
		  ,''
		  ,'');
    
        -- Get the next vendor.  
    FETCH NEXT FROM vendor_cursor   
    INTO @COMPONENT_PART, @PART_NO, @ALTERNATIVE_NO, @LINE_ITEM_NO,	@QTY_PER_ASSEMBLY;  
END   
CLOSE vendor_cursor;  
DEALLOCATE vendor_cursor; 
GO

TRUNCATE TABLE [dbo].[ManufStructAlternate]
GO
INSERT INTO [dbo].[ManufStructAlternate]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_CHG_LEVEL]
           ,[ALTERNATIVE_NO]
           ,[BOM_TYPE_DB]
           ,[ROWSTATE]
           ,[ALTERNATIVE_DESCRIPTION]
           ,[NOTE_TEXT]
           ,[ENG_REVISION]
           ,[MTK_MODE])
 SELECT PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        'B' ROWSTATE, 
        CASE WHEN ALTERNATIVE_NO = '*' THEN 'STANDARD' 
		ELSE 'ALTERNATE' END ALTERNATIVE_DESCRIPTION, 
        '' NOTE_TEXT, 
        ENG_REVISION,
        MTK_MODE
FROM [dbo].[ManufStructure]
GROUP BY PART_NO, 
        CONTRACT,
        ENG_CHG_LEVEL, 
        ALTERNATIVE_NO, 
        BOM_TYPE_DB,
        ENG_REVISION,
        MTK_MODE
GO

TRUNCATE TABLE [dbo].[ManufStructureHead]
GO
INSERT INTO [dbo].[ManufStructureHead]
           ([PART_NO]
           ,[CONTRACT]
           ,[ENG_REVISION]
           ,[ENG_CHG_LEVEL]
           ,[BOM_TYPE_DB]
           ,[ENG_CHG_ORDER]
           ,[CREATE_DATE]
           ,[CUST_WARRANTY_ID]
           ,[NOTE_TEXT]
           ,[MTK_MODE]
           ,[ROWTYPE])
SELECT [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
      ,'' [ENG_CHG_ORDER]
      ,'' [CREATE_DATE]
      ,'' [CUST_WARRANTY_ID]
      ,'' [NOTE_TEXT]
      ,'*' [MTK_MODE]
      ,'ProdStructureHead' [ROWTYPE]
  FROM [dbo].[ManufStructure]
  GROUP BY [PART_NO]
      ,[CONTRACT]
      ,[ENG_REVISION]
      ,[ENG_CHG_LEVEL]
      ,[BOM_TYPE_DB]
GO

---Update ManufStructure Alternate
DECLARE   
   CURSOR get_mfstr IS
      SELECT objid,  objversion 
      FROM PROD_STRUCT_ALTERNATE a
      WHERE use_cost_distribution_DB = 'STANDARD'
      AND EXISTS (SELECT 1 FROM PROD_STRUCTURE b WHERE a.contract = b.contract AND a.part_no = b.part_no);
      
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   Client_SYS.Clear_Attr(attr_);
   
   FOR row_ IN get_mfstr LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      Client_SYS.Clear_Attr(info_);
      Client_SYS.Clear_Attr(attr_);
	  Client_SYS.Add_To_Attr('USE_COST_DISTRIBUTION_DB', 'DISTRIBUTION', attr_);

      PROD_STRUCT_ALTERNATE_API.MODIFY__( info_ , objid_ , objversion_, attr_, 'DO' );
      
      COMMIT;
   END LOOP;   
END;

--------------------------------
DECLARE   
   CURSOR get_qaman IS
      SELECT objid,  objversion
      FROM PROD_STRUCT_ALTERNATE a
	  WHERE a.STATE <> 'Buildable'
	  AND EXISTS (SELECT 1 FROM PROD_STRUCTURE b WHERE a.contract = b.contract 
				 AND a.part_no = b.part_no
				 AND a.ENG_CHG_LEVEL =b.ENG_CHG_LEVEL 
				 AND    a.ALTERNATIVE_NO =b.ALTERNATIVE_NO 
             AND a.BOM_TYPE =b.BOM_TYPE 
             AND b.qty_per_assembly > 0);
   
   info_                VARCHAR2(32000);
   objid_               VARCHAR2(32000);
   objversion_          VARCHAR2(32000);
   attr_cf_             VARCHAR2(26000);
   attr_                VARCHAR2(26000); 
BEGIN
   
   FOR row_ IN get_qaman LOOP
      objid_      := row_.objid;
      objversion_ := row_.objversion;
      attr_ := '';

      PROD_STRUCT_ALTERNATE_API.BUILD__( info_ , objid_ , objversion_ , attr_, 'DO' );
      COMMIT;
   END LOOP;   
END;