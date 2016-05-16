--********************************************************************

CREATE TABLE Partner (
       ParentPartnerID      char(24),
       PartnerID            char(24) NOT NULL,
       CorporationName      varchar(255) NOT NULL,
       OrgUnitName          varchar(255),
       Deleted              smallint,
       Status               varchar(12) NOT NULL,
       Type                 char(12) NOT NULL,
       Self                 smallint,
       TNVersion            varchar(20),
       B2BcomMember         smallint WITH DEFAULT
);

CREATE INDEX idx_Ptnr_CNam_ONam ON Partner
(
       CorporationName,
       OrgUnitName
);

ALTER TABLE Partner
       ADD CONSTRAINT pk_Ptnr_PtnrId PRIMARY KEY (PartnerID) ;


--********************************************************************

CREATE TABLE BizDocAttributeDef 
(
       AttributeName        varchar(255) NOT NULL,
       AttributeID          char(24) NOT NULL,
       AttributeDescription varchar(1024),
       AttributeType        varchar(20) NOT NULL,
       Deleted              smallint,
       Persist              smallint,
       LastModified         timestamp
);


ALTER TABLE BizDocAttributeDef
       ADD CONSTRAINT pk_BDAttDef_AttId PRIMARY KEY (AttributeID) ;

--********************************************************************

CREATE TABLE BizDocTypeDef (
       TypeName             varchar(128) NOT NULL,
       TypeID               char(24) NOT NULL,
       TypeDescription      varchar(255),
       TypeData             blob(250K) NOT NULL,
       Deleted              smallint,
       LastModified         timestamp
);

ALTER TABLE BizDocTypeDef
       ADD CONSTRAINT pk_BDTDef_TypeId PRIMARY KEY (TypeID);

--********************************************************************

CREATE TABLE BinaryType (
       Type                 smallint NOT NULL,
       Description          varchar(255) NOT NULL
);

ALTER TABLE BinaryType
       ADD CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type);

--********************************************************************

CREATE TABLE ContactType (
       Type                 smallint NOT NULL,
       Description          varchar(128) NOT NULL
);

ALTER TABLE ContactType
       ADD CONSTRAINT pk_ContType_Type PRIMARY KEY (Type);


--********************************************************************

CREATE TABLE BizDoc (
       DocID                char(24) NOT NULL,
       DocTypeID            char(24),
       SenderID             char(24) NOT NULL,
       ReceiverID           char(24) NOT NULL,
       NativeID             varchar(100),
       DocTimestamp         timestamp NOT NULL,
       RoutingStatus        varchar(20) NOT NULL,
       GroupID              varchar(100),
       ConversationID       varchar(300),
       UserStatus           varchar(255),
       ReceiveSvc	    varchar(250),
       LastModified         timestamp
);

CREATE INDEX idx_BD_DocTypeId ON BizDoc
(
       DocTypeID
);

CREATE INDEX idx_BD_SenderId ON BizDoc
(
       SenderID
);

CREATE INDEX idx_BD_ReceiverId ON BizDoc
(
       ReceiverID
);

ALTER TABLE BizDoc
       ADD CONSTRAINT pk_BizDoc_DocId PRIMARY KEY (DocID) ;

ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BD_RecrId_Ptnr FOREIGN KEY (ReceiverID)
                             REFERENCES Partner ;

ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BD_SendrId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner ;

ALTER TABLE BizDoc
       ADD CONSTRAINT fk_BD_DTyId_BDTDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef ;

--********************************************************************

CREATE TABLE BizDocArchive (
       DocID                char(24) NOT NULL,
       ArchiveTimestamp     timestamp NOT NULL WITH DEFAULT CURRENT TIMESTAMP,
       DocTimestamp         timestamp NOT NULL,
       SenderCorp           varchar(255) NOT NULL,
       DocTypeName          varchar(128) NOT NULL,
       ReceiverCorp         varchar(255) NOT NULL,
       SenderOrgUnit        varchar(255),
       ReceiverOrgUnit      varchar(255)
);

ALTER TABLE BizDocArchive
       ADD CONSTRAINT pk_BizDocArc_DocId PRIMARY KEY (DocID) ;

--********************************************************************

CREATE TABLE BizDocContentArchive (
       DocID		char(24) NOT NULL,
       PartName		varchar(100) NOT NULL,
       MimeType		varchar(100),
       ContentLength	integer,
       Content		blob(2M),
       PartIndex	integer,
       StorageType	varchar(100),
       StorageRef	varchar(250)
);

ALTER TABLE BizDocContentArchive
       ADD CONSTRAINT pk_BDCArc_DId_Part PRIMARY KEY (DocID,PartName) ;

ALTER TABLE BizDocContentArchive
	ADD CONSTRAINT fk_BDCArc_DId_BDAr FOREIGN KEY(DocID)
		REFERENCES BizDocArchive ;

--********************************************************************

CREATE TABLE BizDocAttribute (
       DocID                char(24) NOT NULL,
       AttributeID          char(24) NOT NULL,
       StringValue          varchar(512),
       NumberValue          float,
       DateValue            timestamp
);

CREATE INDEX idx_BDAtt_AttId ON BizDocAttribute
(
       AttributeID
);

CREATE INDEX idx_BDAtt_DocId ON BizDocAttribute
(
       DocID
);

ALTER TABLE BizDocAttribute
       ADD CONSTRAINT pk_BDAtt_DId_AttId PRIMARY KEY (DocID, AttributeID) ;

ALTER TABLE BizDocAttribute
       ADD CONSTRAINT fk_BDAtt_DId_BDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ;

ALTER TABLE BizDocAttribute
       ADD CONSTRAINT fk_BDA_AtId_BDADef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ;

--********************************************************************

CREATE TABLE BizDocContent (
       DocID         char(24) NOT NULL,
       PartName	     varchar(100) NOT NULL,
       MimeType      varchar(100),
       ContentLength integer,
       Content       blob(2M),
       PartIndex     integer,
       StorageType	varchar(100),
       StorageRef	varchar(250)
);

ALTER TABLE BizDocContent
       ADD CONSTRAINT pk_BDCont_DId_Part PRIMARY KEY (DocID,PartName) ;
       
ALTER TABLE BizDocContent
       ADD CONSTRAINT fk_BDCont_DId_BDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ;

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                char(24) NOT NULL,
       RelatedDocID         char(24) NOT NULL,
       Relationship         varchar(255)
);

CREATE INDEX idx_BDRel_RelDocId ON BizDocRelationship
(
       RelatedDocID
);

CREATE INDEX idx_BDocRel_DocId ON BizDocRelationship
(
       DocID
);

ALTER TABLE BizDocRelationship
       ADD CONSTRAINT pk_BDR_DId_RelDId PRIMARY KEY (DocID, RelatedDocID) ;

ALTER TABLE BizDocRelationship
       ADD CONSTRAINT fk_BDRel_DId_BDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ;

ALTER TABLE BizDocRelationship
       ADD CONSTRAINT fk_BDRel_RelDId_BD FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc ;

--********************************************************************

CREATE TABLE BizDocTypeAttribute (
       AttributeID          char(24) NOT NULL,
       TypeID               char(24) NOT NULL
);

CREATE INDEX idx_BDTypAtt_AttId ON BizDocTypeAttribute
(
       AttributeID
);

CREATE INDEX idx_BDTypAtt_TypId ON BizDocTypeAttribute
(
       TypeID
);

ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT pk_BDTA_AtId_TypId PRIMARY KEY (AttributeID, TypeID) ;

ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT fk_BDTA_TypId_BDTD FOREIGN KEY (TypeID)
                             REFERENCES BizDocTypeDef ;

ALTER TABLE BizDocTypeAttribute
       ADD CONSTRAINT fk_BDTA_AttId_BDAD FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ;

--********************************************************************

CREATE TABLE Contact (
       ContactID            char(24) NOT NULL,
       PartnerID            char(24) NOT NULL,
       Surname              varchar(255),
       GivenName            varchar(255),
       SequenceNumber       smallint NOT NULL,
       RoleDescription		 varchar(128),
       Type                 smallint NOT NULL,
       EmailAddress         varchar(64),
       TelNumber            varchar(60),
       TelExtension         varchar(60),
       FaxNumber            varchar(60),
       PagerNumber          varchar(60)
);

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID
);

ALTER TABLE Contact
       ADD CONSTRAINT pk_Cont_ContId PRIMARY KEY (ContactID) ;

ALTER TABLE Contact
       ADD CONSTRAINT fk_Cont_PtrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

ALTER TABLE Contact 
  ADD CONSTRAINT fk_Cont_Type_CType 
      FOREIGN KEY(Type) REFERENCES ContactType ;

--********************************************************************

CREATE TABLE Address (
       AddressID            char(24) NOT NULL,
       PartnerID            char(24),
       ContactID            char(24),
       AddressLine1         varchar(255),
       AddressLine2         varchar(255),
       AddressLine3         varchar(255),
       City                 varchar(255),
       State_Province       varchar(128),
       Zip_PostalCode       varchar(128),
       Country              varchar(60),
       SequenceNumber       smallint
);

CREATE INDEX idx_Address_ContId ON Address
(
       ContactID
);

CREATE INDEX idx_Address_PtnrId ON Address
(
       PartnerID
);

ALTER TABLE Address
       ADD CONSTRAINT pk_Address_AddrsId PRIMARY KEY (AddressID) ;

ALTER TABLE Address
       ADD CONSTRAINT fk_Addr_PtrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

ALTER TABLE Address
       ADD CONSTRAINT fk_Addr_ConId_Cont FOREIGN KEY (ContactID)
                             REFERENCES Contact ;

--********************************************************************

CREATE TABLE DeliveryService (
       ServiceName          varchar(128) NOT NULL,
       B2BInterface         varchar(512) NOT NULL,
       B2BService           varchar(512) NOT NULL,
       RemoteLocation       varchar(128),
       RemoteUser           varchar(32),
       RemotePassword       varchar(32),
       Scheduled	    int
) ;

ALTER TABLE DeliveryService
       ADD CONSTRAINT pk_DeliServ_SName PRIMARY KEY (ServiceName);

--********************************************************************

CREATE TABLE DeliveryJob (
       JobID                char(24) NOT NULL,
       ServerID             varchar(50) NOT NULL,
       TimeCreated          timestamp,
       TimeUpdated          timestamp,
       JobStatus            varchar(20),
       TimeToWait           integer,
       Retries              integer,
       RetryLimit           integer,
       TransportStatus      varchar(60),
       TransportStatusMessage varchar(512),
       TransportTime        integer,
       DocID                char(24),
       OutputData           blob(250K),
       ServiceName          varchar(128),
       RetryFactor          integer,
       TypeData        	    blob(250K),
       JobType		    varchar(20),
       QueueName	    varchar(254)
) ;

CREATE INDEX idx_DeliJob_SName ON DeliveryJob
(
       ServiceName
) ;

CREATE INDEX idx_DeliJob_DocId ON DeliveryJob
(
       DocID
);

ALTER TABLE DeliveryJob
       ADD CONSTRAINT pk_DeliJob_JobId PRIMARY KEY (JobID);

ALTER TABLE DeliveryJob
       ADD CONSTRAINT fk_DeliJob_DId_BD FOREIGN KEY (DocID)
                             REFERENCES BizDoc;

--********************************************************************

CREATE TABLE Destination (
       DestinationID        char(24) NOT NULL,
       PartnerID            char(24) NOT NULL,
       Protocol             varchar(64) NOT NULL,
       Host                 varchar(64),
       PrimaryAddr          integer NOT NULL,
       Port                 varchar(6),
       Location             varchar(255),
       UserName             varchar(24),
       Password             varchar(24),
       CustomData           blob(100K)
);

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID
);

CREATE INDEX idx_Dest_PId_Pcol ON Destination
(
       PartnerID,
       Protocol
);

ALTER TABLE Destination
       ADD CONSTRAINT pk_Dest_DestnId PRIMARY KEY (DestinationID) ;

ALTER TABLE Destination
       ADD CONSTRAINT fk_Dest_PtrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

--********************************************************************

CREATE TABLE IDType (
       Type                 integer NOT NULL,
       Description          varchar(255) NOT NULL
) ;

ALTER TABLE IDType
       ADD CONSTRAINT pk_IdType_Type PRIMARY KEY (Type) ;

--********************************************************************

CREATE TABLE PartnerBinary (
       PartnerID            char(24) NOT NULL,
       Type                 varchar(20) NOT NULL,
       Value                blob(100K)
) ;

CREATE INDEX idx_PtnrBin_PtnrId ON PartnerBinary
(
       PartnerID
) ;

ALTER TABLE PartnerBinary
       ADD CONSTRAINT pk_PtnrBin_PId_Typ PRIMARY KEY (PartnerID, Type) ;

ALTER TABLE PartnerBinary
       ADD CONSTRAINT fk_PtrBi_PtrId_Ptr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

--********************************************************************

CREATE TABLE PartnerID (
       PartnerIDID          char(24) NOT NULL,
       InternalID           char(24) NOT NULL,
       ExternalID           varchar(128) NOT NULL,
       IDType               integer NOT NULL,
       SequenceNumber       smallint NOT NULL
);

CREATE INDEX idx_PtrIdTbl_IntId ON PartnerID
(
       InternalID
);

ALTER TABLE PartnerID
       ADD CONSTRAINT pk_PtnrId_PtnrIdId PRIMARY KEY (PartnerIDID);

ALTER TABLE PartnerID
       ADD CONSTRAINT fk_PtrId_IntId_Ptr FOREIGN KEY (InternalID)
                             REFERENCES Partner;

--********************************************************************

CREATE TABLE FieldGroup (
       ID           smallint     NOT NULL,
       Description  varchar(128) NOT NULL
) ;

ALTER TABLE FieldGroup
       ADD CONSTRAINT pk_GroupID_ID PRIMARY KEY (ID);

--********************************************************************

CREATE TABLE ProfileField (
       ProfileFieldID       char(24) NOT NULL,
       Name                 char(32),
       Required             smallint,
       Registration         smallint,
       ValidValues          varchar(4000),
       DefaultValue         varchar(128),
       ProfileTbl           varchar(20),
       DataType             varchar(10),
       ProfileCol           varchar(20),
       Deleted              smallint,
       GroupID              smallint NOT NULL,
       Description          varchar(1024),
       MaxLength            integer,
       Display              smallint
);

CREATE INDEX idx_PFld_PTbl_PCol ON ProfileField
(
       ProfileTbl,
       ProfileCol
);

CREATE INDEX idx_ProfFld_Name ON ProfileField
(
       Name
);

ALTER TABLE ProfileField
       ADD CONSTRAINT pk_PFld_ProfFldId PRIMARY KEY (ProfileFieldID);

ALTER TABLE ProfileField
	ADD CONSTRAINT fk_PFld_GID_FldGrp FOREIGN KEY (GroupID)
			   REFERENCES FieldGroup;

--********************************************************************

CREATE TABLE PartnerProfileField (
       ProfileFieldID       char(24) NOT NULL,
       ValueBinary          blob(100K),
       PartnerID            char(24) NOT NULL,
       ValueString          varchar(4000)
) ;

CREATE INDEX idx_PtrPFld_PFldId ON PartnerProfileField
(
       ProfileFieldID
);

CREATE INDEX idx_PtrPFld_PtnrId ON PartnerProfileField
(
       PartnerID
);

ALTER TABLE PartnerProfileField
       ADD CONSTRAINT pk_PPFld_PId_PFlId PRIMARY KEY (PartnerID, ProfileFieldID) ;

ALTER TABLE PartnerProfileField
       ADD CONSTRAINT fk_PPFld_PFId_PFld FOREIGN KEY (ProfileFieldID)
                             REFERENCES ProfileField ;

ALTER TABLE PartnerProfileField
       ADD CONSTRAINT fk_PPFld_PId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

--********************************************************************

CREATE TABLE ProcessingRule (
       RuleIndex            integer NOT NULL,
       RuleDescription      varchar(255),
       RuleName             varchar(128) NOT NULL,
       RuleData             blob(100K),
       LastModified         timestamp,
       Disabled             smallint
);

ALTER TABLE ProcessingRule
       ADD CONSTRAINT pk_PRule_RuleIndex PRIMARY KEY (RuleIndex);

--********************************************************************

CREATE TABLE Remote (
       PartnerID            char(24) NOT NULL,
       Certificate          varchar(255),
       CACertificate        varchar(255),
       RemoteStatus         varchar(12),
       PrivateKey           varchar(255),
       PreferredProtocol    varchar(64),
       PollingFrequency     float,
       DeliveryMaxRetries   smallint,
       DeliveryRetryWait    integer,
       PollingProtocol      varchar(64),
       RetryFactor	    integer,
       DeliveryQueue	    varchar(254)
);

ALTER TABLE Remote
       ADD CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID) ;

ALTER TABLE Remote
       ADD CONSTRAINT fk_Remote_PId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

--********************************************************************

CREATE TABLE ActivityLog(
       RelatedDocID         char(24),
       EntryTimestamp       timestamp NOT NULL,
       EntryType            integer NOT NULL,
       EntryClass           varchar(20),
       BriefMessage         varchar(240) NOT NULL,
       RelatedPartnerID     char(24),
       RelatedInstanceID	 varchar(128),
       RelatedStepID			 varchar(128),
       B2BUser              varchar(20),
       FullMessage          varchar(1024)
);

CREATE INDEX idx_ALog_RelDocId ON ActivityLog
(
       RelatedDocID
);

CREATE INDEX idx_ALog_RelPtnrId ON ActivityLog
(
       RelatedPartnerID
);

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ALog_RPtrId_Ptr FOREIGN KEY (RelatedPartnerID)
                             REFERENCES Partner;

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ALog_RDId_BDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc;

--********************************************************************

CREATE TABLE DeliveryQueue (
	QueueName            varchar(254) NOT NULL,
	QueueType            varchar(12) NOT NULL,
	QueueState           varchar(12) NOT NULL,
	Schedule             blob(25K) NOT NULL
);

CREATE INDEX idx_DeliQ_QType ON DeliveryQueue
(
  QueueType
);

ALTER TABLE DeliveryQueue
       ADD CONSTRAINT pk_DeliQ_QueueName PRIMARY KEY (QueueName) ;

--********************************************************************

CREATE TABLE SecurityData
(
	DataID					char(24) NOT NULL,
	OwnerID					char(24) NOT NULL,
	CertificateData				blob(100K)
);

CREATE INDEX Idx_SecDat_OwnrId ON SecurityData( OwnerID ) ;


ALTER TABLE SecurityData ADD CONSTRAINT pk_SecDat_DataId
	PRIMARY KEY ( DataID ) ;

ALTER TABLE SecurityData ADD CONSTRAINT fk_SecDt_OwnId_Ptr
	FOREIGN KEY ( OwnerID ) REFERENCES Partner( PartnerID ) ;

--********************************************************************

CREATE TABLE SecurityAgreement
(
	AgreementID				char(24) NOT NULL,
	SenderID				char(24),
	ReceiverID				char(24),
	SecurityUsage			varchar(20) NOT NULL,
	SecurityDataID			char(24) NOT NULL
);

CREATE INDEX Idx_SecAgr_SndrId ON SecurityAgreement( SenderID ) ;

CREATE INDEX Idx_SecAgr_RcvrId ON SecurityAgreement( ReceiverID ) ;

CREATE INDEX Idx_SecAgr_Usg ON SecurityAgreement( SecurityUsage ) ;

ALTER TABLE SecurityAgreement ADD CONSTRAINT pk_SecAgr_AgrId
	PRIMARY KEY ( AgreementID ) ;

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAg_SndId_Ptr
	FOREIGN KEY ( SenderID ) REFERENCES Partner( PartnerID ) ;

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAg_RcrId_Ptr
	FOREIGN KEY ( ReceiverID ) REFERENCES Partner( PartnerID ) ;

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SAg_SDtId_SecDt
	FOREIGN KEY ( SecurityDataID ) REFERENCES SecurityData( DataID ) ;


--********************************************************************

CREATE TABLE TPA (
       TpaID            char(24) NOT NULL,
       SenderID         char(24),
       ReceiverID       char(24),
       AgreementID      varchar(254) NOT NULL,
       TimeCreated      timestamp,
       LastModified     timestamp,
       ControlNumber    integer,
       Status           varchar(20),
       ExportService    varchar(254),
       InitService      varchar(254),
       DataSchema       varchar(254),
       DataStatus       varchar(24),
       TpaData          blob(50K),
       Version          varchar(20)
);

CREATE INDEX idx_TPA_SenderId ON TPA
(
       SenderID
);

CREATE INDEX idx_TPA_ReceiverId ON TPA
(
       ReceiverID
);

CREATE INDEX idx_TPA_AgrementId ON TPA
(
       AgreementID
);

ALTER TABLE TPA
       ADD CONSTRAINT pk_TPA_TpaId PRIMARY KEY (TpaID);

--********************************************************************

CREATE TABLE BizDocUniqueKeys (
		DocID           char(24) NOT NULL,
		UniqueKey       varchar(254) NOT NULL
);

ALTER TABLE BizDocUniqueKeys
	ADD CONSTRAINT pk_BDUniq_UniqKey PRIMARY KEY (UniqueKey) ;

--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         integer NOT NULL,
       MinorVersion         integer NOT NULL
);

ALTER TABLE TNModelVersion
       ADD CONSTRAINT pk_TNMVer_MajV_MiV PRIMARY KEY (MajorVersion, MinorVersion);


--********************************************************************

CREATE TABLE EDITRACKING (
       DOCID                char(24) NOT NULL,
       DOCTYPEID            char(24) NOT NULL,
       SENDERID             char(24) NOT NULL,
       RECEIVERID           char(24) NOT NULL,
       ENVELOPEID           varchar(100),
       GROUPID		    varchar(100),
       TRANSACTIONSETID     varchar(100),
       GROUPTYPE 	    varchar(100),
       GROUPVERSION	    varchar(100),
       DOCTIMESTAMP         timestamp NOT NULL,
       FATIMESTAMP          timestamp,
       FASTATUS             integer NOT NULL,
       RELATEDDOCID	    char(24)
);

CREATE INDEX idx_EDITRAC_SNDRID ON EDITRACKING
(
       SENDERID
);

CREATE INDEX idx_EDITRAC_RECRID ON EDITRACKING
(
       RECEIVERID
);

CREATE INDEX idx_EDITRAC_GRPID ON EDITRACKING
(
       GROUPID
);

CREATE INDEX idx_EDITRAC_TSTAMP ON EDITRACKING
(
       DOCTIMESTAMP
);

CREATE INDEX idx_EDITRAC_FASTAT ON EDITRACKING
(
       FASTATUS
);

ALTER TABLE EDITRACKING
       ADD CONSTRAINT pk_EDITRAC_DOCID PRIMARY KEY (DOCID) ;

--********************************************************************