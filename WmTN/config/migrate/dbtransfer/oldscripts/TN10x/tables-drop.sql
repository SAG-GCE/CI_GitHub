-- it's a good idea to do this within the scope of a transaction
-- in case something fails
-- begin tran;

-- drop all delivery-related tables
DROP TABLE DeliveryJob;
DROP TABLE DeliveryService;

-- drop all document-related tables
DROP TABLE ActivityLog;
DROP TABLE BizDocArchive;
DROP TABLE BizDocAttribute;
DROP TABLE BizDocTypeAttribute;
DROP TABLE BizDocAttributeDef;
DROP TABLE BizDocContent;
DROP TABLE BizDocRelationship;
DROP TABLE BizDoc;
DROP TABLE BizDocTypeDef;

-- drop all partner-related tables
DROP TABLE BinaryType;
DROP TABLE ContactType;
DROP TABLE IDType;
DROP TABLE Address;
DROP TABLE Contact;
DROP TABLE Destination;
DROP TABLE PartnerBinary;
DROP TABLE PartnerID;
DROP TABLE PartnerProfileField;
DROP TABLE ProcessingRule;
DROP TABLE ProfileField;
DROP TABLE Remote;
DROP TABLE Partner;

-- drop model version
DROP TABLE TNModelVersion;

-- commit tran;
