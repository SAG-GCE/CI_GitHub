begin tran

--********************************************************************

CREATE TABLE Partner (
       ParentPartnerID      char(24) NULL,
       PartnerID            char(24) NOT NULL,
       							 -- i18n, 64 to 255
       CorporationName      varchar(255) NOT NULL,
       							 -- i18n, 64 to 255
       OrgUnitName          varchar(255) NULL,
       Deleted              bit,
       Status               varchar(12) NOT NULL,
       Type                 char(12) NOT NULL,
       Self                 bit,
       TNVersion            varchar(20) NULL,
       B2BcomMember         bit NULL DEFAULT 0
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

--********************************************************************

CREATE TABLE BizDocAttributeDef (
									 -- i18n, 64 to 255
       AttributeName        varchar(255) NOT NULL,
       AttributeID          char(24) NOT NULL,
       							 -- i18n, 256 to 1024
       AttributeDescription varchar(1024) NULL,
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
									 --i18n, 64 to 128
       TypeName             varchar(128) NOT NULL,
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
       							 -- i18n 24 to 255
       Description          varchar(255) NOT NULL
)
go

ALTER TABLE BinaryType
       ADD CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type)
go

--********************************************************************

CREATE TABLE ContactType (
       Type                 smallint NOT NULL,
									 -- i18n, 24 to 128       
       Description          varchar(128) NOT NULL
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
       ConversationID       varchar(300) NULL,
                            --i18n 100 to 255
       UserStatus           varchar(255) NULL,
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
       SenderOrgUnit        varchar(64) NULL,
       ReceiverOrgUnit      varchar(64) NULL
)
go


ALTER TABLE BizDocArchive
       ADD CONSTRAINT pk_BizDocArc_DocId PRIMARY KEY (DocID)
go

--********************************************************************

CREATE TABLE BizDocContentArchive (
       DocID		char(24) NOT NULL,
       PartName		varchar(100) NOT NULL,
       MimeType		varchar(100),
       ContentLength	int,
       Content		image,
       PartIndex	int
)
go


ALTER TABLE BizDocContentArchive
       ADD CONSTRAINT pk_BDContArc_DocId_PartName PRIMARY KEY (DocID,PartName)
go


ALTER TABLE BizDocContentArchive
	ADD CONSTRAINT fk_BDContArc_DocId_BizDocArc FOREIGN KEY(DocID)
		REFERENCES BizDocArchive
go

--********************************************************************

CREATE TABLE BizDocAttribute (
       DocID                char(24) NOT NULL,
       AttributeID          char(24) NOT NULL,
       							 -- i18n 256 to 512
       StringValue          varchar(512) NULL,
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
       DocID         char(24) NOT NULL,
       PartName	     varchar(100) NOT NULL,
       MimeType      varchar(100) NULL,
       ContentLength int NULL,
       Content       image NULL,
       PartIndex     int NULL
)
go


ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BizDocCont_DocId_PartName PRIMARY KEY (DocID,PartName)
go

ALTER TABLE BizDocContent
       ADD CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc
go

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                char(24) NOT NULL,
       RelatedDocID         char(24) NOT NULL,
       							 -- i18n, 80 to 255
       Relationship         varchar(255) NULL
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

CREATE TABLE Contact (
       ContactID            char(24) NOT NULL,
       PartnerID            char(24) NOT NULL,
									 -- i18n, 40 to 255       
       Surname              varchar(255) NULL,
									 -- i18n, 40 to 255
       GivenName            varchar(255) NULL,
       SequenceNumber       smallint NOT NULL,
                            -- i18n, 64 to 128
       Role                 varchar(128) NULL,
       Type                 smallint NOT NULL,
       EmailAddress         varchar(64) NULL,
									 -- i18n, 20 to 60       
       TelNumber            varchar(60) NULL,
									 -- i18n, 20 to 60       
       TelExtension         varchar(60) NULL,
									 -- i18n, 20 to 60       
       FaxNumber            varchar(60) NULL,
									 -- i18n, 20 to 60       
       PagerNumber          varchar(60) NULL
)
go

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID
)
go

ALTER TABLE Contact
       ADD CONSTRAINT pk_Cont_ContId PRIMARY KEY (ContactID)
go

ALTER TABLE Contact
       ADD CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

ALTER TABLE Contact 
  ADD CONSTRAINT fk_Contact_Type_ContType 
      FOREIGN KEY(Type) REFERENCES ContactType
go

--********************************************************************

CREATE TABLE Address (
       AddressID            char(24) NOT NULL,
       PartnerID            char(24) NULL,
       ContactID            char(24) NULL,
                            -- i18n 50 to 255
       AddressLine1         varchar(255) NULL,
                            -- i18n 50 to 255
       AddressLine2         varchar(255) NULL,
                            -- i18n 50 to 255
       AddressLine3         varchar(255) NULL,
                            -- i18n 50 to 255
       City                 varchar(255) NULL,
       							 -- i18n 20 to 128
       State_Province       varchar(128) NULL,
                            -- i18n 12 to 128
       Zip_PostalCode       varchar(128) NULL,
									 -- i18n 18 to 60
       Country              varchar(60) NULL,
       SequenceNumber       smallint NULL
)
go

CREATE INDEX idx_Address_ContId ON Address
(
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
       ADD CONSTRAINT fk_Address_ContId_Cont FOREIGN KEY (ContactID)
                             REFERENCES Contact
go

--********************************************************************

CREATE TABLE DeliveryService (
									 -- i18n, 64 to 128
       ServiceName          varchar(128) NOT NULL,
       							 -- i18n, 128 to 512
       B2BInterface         varchar(512) NOT NULL,
       							 -- i18n, 128 to 512
       B2BService           varchar(512) NOT NULL,
       RemoteLocation       varchar(128) NULL,
       RemoteUser           varchar(32) NULL,
       RemotePassword       varchar(32) NULL
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
       							 -- i18n 20 to 60
       TransportStatus      varchar(60) NULL,
       							 -- i18n 256 to 512
       TransportStatusMessage varchar(512) NULL,
       TransportTime        int NULL,
       DocID                char(24) NULL,
       OutputData           image NULL,
      							 -- i18n 64 to 128
       ServiceName          varchar(128) NULL,
       RetryFactor          int NULL,
       TypeData        	    image NULL,
       JobType		    varchar(20) NULL
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

--********************************************************************

CREATE TABLE Destination (
       DestinationID        char(24) NOT NULL,
       PartnerID            char(24) NOT NULL,
       Protocol             char(8) NOT NULL,
       Host                 varchar(64) NULL,
       PrimaryAddr          int NOT NULL,
       Port                 varchar(6) NULL,
                            -- i18n, 128 to 255
       Location             varchar(255) NULL,
       UserName             varchar(24) NULL,
       Password             varchar(24) NULL,
       CustomData           image NULL
)
go

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID
)
go

CREATE INDEX idx_Dest_PtnrId_Protocol ON Destination
(
       PartnerID,
       Protocol
)
go

ALTER TABLE Destination
       ADD CONSTRAINT pk_Dest_DestinationId PRIMARY KEY (DestinationID)
go

ALTER TABLE Destination
       ADD CONSTRAINT fk_Dest_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE IDType (
       Type                 int NOT NULL,
       							 -- i18n, 128 to 255
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
       PartnerIDID          char(24) NOT NULL,
       InternalID           char(24) NOT NULL,
       ExternalID           varchar(128) NOT NULL,
       IDType               int NOT NULL,
       SequenceNumber       smallint NOT NULL
)
go

CREATE INDEX idx_PtnrIdTbl_InternalId ON PartnerID
(
       InternalID
)
go

ALTER TABLE PartnerID
       ADD CONSTRAINT pk_PtnrIdTbl_PtnrIdId PRIMARY KEY (PartnerIDID)
go

ALTER TABLE PartnerID
       ADD CONSTRAINT fk_PtnrIdTbl_InternalId_Ptnr FOREIGN KEY (InternalID)
                             REFERENCES Partner
go

--********************************************************************

CREATE TABLE FieldGroup (
       ID           smallint     NOT NULL,
       Description  varchar(128) NOT NULL
)
go

ALTER TABLE FieldGroup
       ADD CONSTRAINT pk_GroupID_ID PRIMARY KEY (ID)
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

ALTER TABLE ProfileField
	ADD CONSTRAINT fk_ProfileFld_GrpID_FieldGrp FOREIGN KEY (GroupID)
			   REFERENCES FieldGroup
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
       							 -- i18n, 64 to 128
       RuleName             varchar(128) NOT NULL,
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
       PollingProtocol      varchar(8) NULL,
       RetryFactor	    int NULL
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
CREATE TABLE ConversationScript (
   ScriptName  varchar(64) NOT NULL,
   ScriptIndex int,
   ScriptData  image
);

ALTER TABLE ConversationScript
       ADD CONSTRAINT pk_ConvScr_ScriptName PRIMARY KEY (ScriptName)

go

--********************************************************************

CREATE TABLE Conversation (
   ConversationID       varchar(300) NOT NULL,
   ConversationStatus   varchar(40),
   ScriptName           varchar(64),
   TimeCreated          datetime,
   ParentConversationID varchar(300),
   CurrentStep		varchar(64),
   Timeout		datetime,
   LastModified         datetime
);

ALTER TABLE Conversation
       ADD CONSTRAINT pk_Conv_ConvId PRIMARY KEY (ConversationID)
;

ALTER TABLE Conversation
	ADD CONSTRAINT fk_Conv_ParentConvID_Conv FOREIGN KEY (ParentConversationID) 
				REFERENCES Conversation
go

--********************************************************************

CREATE TABLE RoleBinding (
    ConversationID   varchar(300) NOT NULL,
    RoleName         varchar(128) NOT NULL,
    PartnerID        char(24) NOT NULL,
    RoleType         int NOT NULL
); 

ALTER TABLE RoleBinding
   ADD CONSTRAINT pk_RoleBind_ConvID_RoldName 
      PRIMARY KEY(ConversationID, RoleName)
;

ALTER TABLE RoleBinding
       ADD CONSTRAINT fk_RoleBind_ConvId_Conv FOREIGN KEY (ConversationID)
                             REFERENCES Conversation
;

ALTER TABLE RoleBinding
       ADD CONSTRAINT fk_RoleBind_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner

go

--********************************************************************

CREATE TABLE ActivityLog (
       RelatedDocID         char(24) NULL,
       EntryTimestamp       datetime NOT NULL,
       EntryType            int NOT NULL,
       EntryClass           varchar(20) NULL,
      							 -- i18n 80 to 240
       BriefMessage         varchar(240) NOT NULL,
       RelatedPartnerID     char(24) NULL,
       RelatedConversationID varchar(300) NULL,
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

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedConvId_Conv FOREIGN KEY (RelatedConversationID)
                             REFERENCES Conversation
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
