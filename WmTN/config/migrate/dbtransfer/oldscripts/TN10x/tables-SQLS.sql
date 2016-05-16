begin tran

--********************************************************************

CREATE TABLE Partner (
       ParentPartnerID      char(24) NULL,
       PartnerID            char(24) NOT NULL,
       CorporationName      varchar(64) NOT NULL,
       OrgUnitName          varchar(64) NULL,
       Deleted              bit,
       Status               varchar(12) NOT NULL,
       Type                 char(12) NOT NULL,
       Self                 bit,
       TNVersion            varchar(20) NULL
)
go

CREATE INDEX idx_Ptnr_ParentPtnrId ON Partner
(
       ParentPartnerID
)
go

CREATE INDEX idx_Ptnr_CorpName_OrgUnitName ON Partner
(
       CorporationName,
       OrgUnitName
)
go


ALTER TABLE Partner
       ADD CONSTRAINT pk_Ptnr_PtnrId PRIMARY KEY (PartnerID)
go

ALTER TABLE Partner
       ADD CONSTRAINT fk_Ptnr_ParentPtnrId_Ptnr FOREIGN KEY (ParentPartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE BizDocAttributeDef (
       AttributeName        varchar(64) NOT NULL,
       AttributeID          char(24) NOT NULL,
       AttributeDescription varchar(256) NULL,
       AttributeType        varchar(10) NOT NULL,
       Deleted              bit,
       LastModified         datetime NULL
)
go


ALTER TABLE BizDocAttributeDef
       ADD CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID)
go


--********************************************************************

CREATE TABLE BizDocTypeDef (
       TypeName             varchar(64) NOT NULL,
       TypeID               char(24) NOT NULL,
       TypeDescription      varchar(256) NULL,
       TypeData             image NOT NULL,
       Deleted              bit,
       LastModified         datetime NULL
)
go


ALTER TABLE BizDocTypeDef
       ADD CONSTRAINT pk_BizDocTypeDef_TypeId PRIMARY KEY (TypeID)
go

--********************************************************************

CREATE TABLE BinaryType (
       Type                 smallint NOT NULL,
       Description          varchar(24) NOT NULL
)
go

ALTER TABLE BinaryType
       ADD CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type)
go

--********************************************************************

CREATE TABLE ContactType (
       Type                 smallint NOT NULL,
       Description          varchar(24) NOT NULL
)
go


ALTER TABLE ContactType
       ADD CONSTRAINT pk_ContType_Type PRIMARY KEY (Type)
go


--********************************************************************

CREATE TABLE BizDoc (
       DocID                char(24) NOT NULL,
       DocTypeID            char(24) NULL,
       SenderID             char(24) NOT NULL,
       ReceiverID           char(24) NOT NULL,
       NativeID             varchar(100) NULL,
       DocTimestamp         datetime NOT NULL,
       RoutingStatus        varchar(20) NOT NULL,
       GroupID              varchar(100) NULL,
       ConversationID       varchar(100) NULL,
       UserStatus           varchar(100) NULL,
       LastModified         datetime NULL
)
go

CREATE INDEX idx_BizDoc_DocTypeId ON BizDoc
(
       DocTypeID
)
go

CREATE INDEX idx_BizDoc_SenderId ON BizDoc
(
       SenderID
)
go

CREATE INDEX idx_BizDoc_ReceiverId ON BizDoc
(
       ReceiverID
)
go


ALTER TABLE BizDoc
       ADD CONSTRAINT pk_BizDoc_DocId PRIMARY KEY (DocID)
go

ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BizDoc_ReceiverId_Ptnr FOREIGN KEY (ReceiverID)
                             REFERENCES Partner
go


ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BizDoc_SenderId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner
go


ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BizDoc_DocTyId_BizDocTypDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef
go


--********************************************************************

CREATE TABLE BizDocArchive (
       DocID                char(24) NOT NULL,
       ArchiveTimestamp     datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
       DocTimestamp         datetime NOT NULL,
       SenderCorp           varchar(64) NOT NULL,
       DocTypeName          varchar(64) NOT NULL,
       ReceiverCorp         varchar(64) NOT NULL,
       Content              image NOT NULL,
       SenderOrgUnit        varchar(64) NULL,
       ReceiverOrgUnit      varchar(64) NULL
)
go


ALTER TABLE BizDocArchive
       ADD CONSTRAINT pk_BizDocArc_DocId PRIMARY KEY (DocID)
go

--********************************************************************

CREATE TABLE BizDocAttribute (
       DocID                char(24) NOT NULL,
       AttributeID          char(24) NOT NULL,
       StringValue          varchar(256) NULL,
       NumberValue          float NULL,
       DateValue            datetime NULL
)
go

CREATE INDEX idx_BizDocAtt_AttId ON BizDocAttribute
(
       AttributeID
)
go

CREATE INDEX idx_BizDocAtt_DocId ON BizDocAttribute
(
       DocID
)
go


ALTER TABLE BizDocAttribute
       ADD CONSTRAINT pk_BizDocAtt_DocId_AttId PRIMARY KEY (DocID, AttributeID)
go

ALTER TABLE BizDocAttribute
       ADD CONSTRAINT fk_BizDocAtt_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc
go


ALTER TABLE BizDocAttribute
       ADD CONSTRAINT fk_BizDocAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef
go

--********************************************************************

CREATE TABLE BizDocContent (
       DocID                char(24) NOT NULL,
       Content              image NOT NULL,
       ContentLength        int NULL
)
go


ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BizDocCont_DocId PRIMARY KEY (DocID)
go

ALTER TABLE BizDocContent
       ADD CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc
go

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                char(24) NOT NULL,
       RelatedDocID         char(24) NOT NULL,
       Relationship         varchar(80) NULL
)
go

CREATE INDEX idx_BizDocRel_RelatedDocId ON BizDocRelationship
(
       RelatedDocID
)
go

CREATE INDEX idx_BizDocRel_DocId ON BizDocRelationship
(
       DocID
)
go


ALTER TABLE BizDocRelationship
       ADD CONSTRAINT pk_BizDocRel_DocId_RelatDocId PRIMARY KEY (DocID, RelatedDocID)
go

ALTER TABLE BizDocRelationship
       ADD CONSTRAINT fk_BizDocRel_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc
go


ALTER TABLE BizDocRelationship
       ADD CONSTRAINT fk_BizDocRel_RelatDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc
go

--********************************************************************

CREATE TABLE BizDocTypeAttribute (
       AttributeID          char(24) NOT NULL,
       TypeID               char(24) NOT NULL
)
go

CREATE INDEX idx_BizDocTypeAtt_AttId ON BizDocTypeAttribute
(
       AttributeID
)
go

CREATE INDEX idx_BizDocTypeAtt_TypeId ON BizDocTypeAttribute
(
       TypeID
)
go


ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT pk_BizDocTypeAtt_AttId_TypeId PRIMARY KEY (AttributeID, TypeID)
go

ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT fk_BDocTypAtt_TypId_BDocTypDef FOREIGN KEY (TypeID)
                             REFERENCES BizDocTypeDef
go


ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT fk_BDocTypAtt_AttId_BDocAttDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef
go

--********************************************************************

CREATE TABLE ActivityLog (
       RelatedDocID         char(24) NULL,
       EntryTimestamp       datetime NOT NULL,
       EntryType            int NOT NULL,
       EntryClass           varchar(20) NULL,
       BriefMessage         varchar(80) NOT NULL,
       RelatedPartnerID     char(24) NULL,
       B2BUser              varchar(20) NULL,
       FullMessage          varchar(1024) NULL
)
go

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
       RelatedDocID
)
go

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
       RelatedPartnerID
)
go

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                             REFERENCES Partner
go

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc
go

--********************************************************************

CREATE TABLE Contact (
       PartnerID            char(24) NOT NULL,
       Surname              varchar(40) NULL,
       ContactID            char(24) NOT NULL,
       SequenceNumber       smallint NOT NULL,
       GivenName            varchar(40) NOT NULL,
       Role                 varchar(64) NULL,
       Type                 smallint NOT NULL,
       EmailAddress         varchar(64) NULL,
       TelNumber            varchar(20) NULL,
       TelExtension         varchar(20) NULL,
       FaxNumber            varchar(20) NULL,
       PagerNumber          varchar(20) NULL
)
go

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID
)
go

ALTER TABLE Contact
       ADD CONSTRAINT pk_Cont_PtnrId_ContId PRIMARY KEY (PartnerID, ContactID)
go

ALTER TABLE Contact
       ADD CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE Address (
       AddressID            char(24) NOT NULL,
       PartnerID            char(24) NULL,
       ContactID            char(24) NULL,
       AddressLine1         varchar(50) NULL,
       AddressLine2         varchar(50) NULL,
       AddressLine3         varchar(50) NULL,
       City                 varchar(50) NULL,
       State_Province       varchar(20) NULL,
       Zip_PostalCode       varchar(12) NULL,
       Country              varchar(18) NULL
)
go

CREATE INDEX idx_Address_PtnrId_ContId ON Address
(
       PartnerID,
       ContactID
)
go

CREATE INDEX idx_Address_PtnrId ON Address
(
       PartnerID
)
go


ALTER TABLE Address
       ADD CONSTRAINT pk_Address_AddressId PRIMARY KEY (AddressID)
go

ALTER TABLE Address
       ADD CONSTRAINT fk_Address_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go


ALTER TABLE Address
       ADD CONSTRAINT fk_Address_PtnrId_ContId_Cont FOREIGN KEY (PartnerID, ContactID)
                             REFERENCES Contact
go

--********************************************************************

CREATE TABLE DeliveryService (
       ServiceName          varchar(48) NOT NULL,
       B2BInterface         varchar(20) NOT NULL,
       B2BService           varchar(20) NOT NULL,
       RemoteLocation       varchar(50) NULL,
       RemoteUser           varchar(20) NULL,
       RemotePassword       varchar(20) NULL
)
go


ALTER TABLE DeliveryService
       ADD CONSTRAINT pk_DeliServ_ServName PRIMARY KEY (ServiceName)
go

--********************************************************************

CREATE TABLE DeliveryJob (
       JobID                char(24) NOT NULL,
       ServerID             varchar(50) NOT NULL,
       TimeCreated          datetime NULL,
       TimeUpdated          datetime NULL,
       JobStatus            varchar(20) NULL,
       TimeToWait           int NULL,
       Retries              int NULL,
       RetryLimit           int NULL,
       TransportStatus      varchar(20) NULL,
       TransportStatusMessage varchar(80) NULL,
       TransportTime        int NULL,
       DocID                char(24) NULL,
       OutputData           image NULL,
       ServiceName          varchar(48) NULL
)
go

CREATE INDEX idx_DeliJob_ServName ON DeliveryJob
(
       ServiceName
)
go

CREATE INDEX idx_DeliJob_DocId ON DeliveryJob
(
       DocID
)
go


ALTER TABLE DeliveryJob
       ADD CONSTRAINT pk_DeliJob_JobId PRIMARY KEY (JobID)
go

ALTER TABLE DeliveryJob
       ADD CONSTRAINT fk_DeliJob_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc
go


ALTER TABLE DeliveryJob
       ADD CONSTRAINT fk_DeliJob_ServName_DeliServ FOREIGN KEY (ServiceName)
                             REFERENCES DeliveryService
go

--********************************************************************

CREATE TABLE Destination (
       PartnerID            char(24) NOT NULL,
       Protocol             char(8) NOT NULL,
       Host                 varchar(64) NULL,
       PrimaryAddr          int NOT NULL,
       Port                 varchar(6) NULL,
       Location             varchar(128) NULL,
       UserName             varchar(24) NULL,
       Password             varchar(24) NULL
)
go

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID
)
go


ALTER TABLE Destination
       ADD CONSTRAINT pk_Dest_PtnrId_Prot_PrimAddr PRIMARY KEY (PartnerID, Protocol, PrimaryAddr)
go

ALTER TABLE Destination
       ADD CONSTRAINT fk_Dest_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE IDType (
       Type                 int NOT NULL,
       Description          varchar(128) NOT NULL
)
go


ALTER TABLE IDType
       ADD CONSTRAINT pk_IdType_Type PRIMARY KEY (Type)
go

--********************************************************************

CREATE TABLE PartnerBinary (
       PartnerID            char(24) NOT NULL,
       Type                 varchar(20) NOT NULL,
       Value                image NULL
)
go

CREATE INDEX idx_PtnrBin_PtnrId ON PartnerBinary
(
       PartnerID
)
go


ALTER TABLE PartnerBinary
       ADD CONSTRAINT pk_PtnrBin_PtnrId_Type PRIMARY KEY (PartnerID, Type)
go

ALTER TABLE PartnerBinary
       ADD CONSTRAINT fk_PtnrBin_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE PartnerID (
       InternalID           char(24) NOT NULL,
       ExternalID           char(35) NOT NULL,
       IDType               int NOT NULL
)
go

CREATE INDEX idx_PtnrIdTbl_InternalId ON PartnerID
(
       InternalID
)
go

ALTER TABLE PartnerID
       ADD CONSTRAINT pk_PtnrIdTbl_ExternalId_IdType PRIMARY KEY (ExternalID, IDType)
go

ALTER TABLE PartnerID
       ADD CONSTRAINT fk_PtnrIdTbl_InternalId_Ptnr FOREIGN KEY (InternalID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE ProfileField (
       ProfileFieldID       char(24) NOT NULL,
       Name                 char(32) NULL,
       Required             bit,
       Registration         bit,
       ValidValues          text NULL,
       DefaultValue         varchar(128) NULL,
       ProfileTbl           varchar(20) NULL,
       DataType             varchar(10) NULL,
       ProfileCol           varchar(20) NULL,
       Deleted              bit,
       GroupID              smallint NOT NULL,
       Description          varchar(1024) NULL,
       MaxLength            int NULL,
       Display              bit
)
go

CREATE INDEX idx_ProfFld_ProfTbl_ProfCol ON ProfileField
(
       ProfileTbl,
       ProfileCol
)
go

CREATE INDEX idx_ProfFld_Name ON ProfileField
(
       Name
)
go

ALTER TABLE ProfileField
       ADD CONSTRAINT pk_ProfFld_ProfFldId PRIMARY KEY (ProfileFieldID)
go

--********************************************************************

CREATE TABLE PartnerProfileField (
       ProfileFieldID       char(24) NOT NULL,
       ValueBinary          image NULL,
       PartnerID            char(24) NOT NULL,
       ValueString          text NULL
)
go

CREATE INDEX idx_PtnrProFld_ProFldId ON PartnerProfileField
(
       ProfileFieldID
)
go

CREATE INDEX idx_PtnrProFld_PtnrId ON PartnerProfileField
(
       PartnerID
)
go


ALTER TABLE PartnerProfileField
       ADD CONSTRAINT pk_PtnrProFld_PtnrId_ProFldId PRIMARY KEY (PartnerID, ProfileFieldID)
go

ALTER TABLE PartnerProfileField
       ADD CONSTRAINT fk_PtnrProFld_ProFldId_ProFld FOREIGN KEY (ProfileFieldID)
                             REFERENCES ProfileField
go


ALTER TABLE PartnerProfileField
       ADD CONSTRAINT fk_PtnrProFld_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE ProcessingRule (
       RuleIndex            int NOT NULL,
       RuleDescription      varchar(256) NULL,
       RuleName             varchar(64) NOT NULL,
       RuleData             image NULL,
       LastModified         datetime NULL,
       Disabled             bit
)
go


ALTER TABLE ProcessingRule
       ADD CONSTRAINT pk_ProcessingRule_RuleIndex PRIMARY KEY (RuleIndex)
go

--********************************************************************

CREATE TABLE Remote (
       PartnerID            char(24) NOT NULL,
       Certificate          varchar(255) NULL,
       CACertificate        varchar(255) NULL,
       RemoteStatus         varchar(12) NULL,
       PrivateKey           varchar(255) NULL,
       PreferredProtocol    varchar(8) NULL,
       PollingFrequency     float NULL,
       DeliveryMaxRetries   smallint NULL,
       DeliveryRetryWait    int NULL,
       PollingProtocol      varchar(8) NULL
)
go


ALTER TABLE Remote
       ADD CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID)
go

ALTER TABLE Remote
       ADD CONSTRAINT fk_Remote_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         int NOT NULL,
       MinorVersion         int NOT NULL
)
go


ALTER TABLE TNModelVersion
       ADD CONSTRAINT pk_TNModelVer_MajVer_MinorVer PRIMARY KEY (MajorVersion, MinorVersion)
go

--********************************************************************

commit tran
go
