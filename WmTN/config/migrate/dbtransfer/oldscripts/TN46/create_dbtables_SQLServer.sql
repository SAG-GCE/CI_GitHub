begin tran

--********************************************************************

CREATE TABLE Partner (
       ParentPartnerID      char(24) NULL,
       PartnerID            char(24) NOT NULL,
       CorporationName      varchar(255) NOT NULL,
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
       AttributeName        varchar(255) NOT NULL,
       AttributeID          char(24) NOT NULL,
       AttributeDescription varchar(1024) NULL,
       AttributeType        varchar(20) NOT NULL,
       Deleted              bit,
       Persist              bit,
       LastModified         datetime NULL
)
go


ALTER TABLE BizDocAttributeDef
       ADD CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID)
go


--********************************************************************

CREATE TABLE BizDocTypeDef (
       TypeName             varchar(128) NOT NULL,
       TypeID               char(24) NOT NULL,
       TypeDescription      varchar(255) NULL,
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
       Description          varchar(255) NOT NULL
)
go

ALTER TABLE BinaryType
       ADD CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type)
go

--********************************************************************

CREATE TABLE ContactType (
       Type                 smallint NOT NULL,
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
       SenderCorp           varchar(255) NOT NULL,
       DocTypeName          varchar(128) NOT NULL,
       ReceiverCorp         varchar(255) NOT NULL,
       SenderOrgUnit        varchar(255) NULL,
       ReceiverOrgUnit      varchar(255) NULL
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
       PartIndex	int,
       StorageType  varchar(100),
       StorageRef   varchar(250)
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
       PartIndex     int NULL,
       StorageType   varchar(100) NULL,
       StorageRef    varchar(250) NULL
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
       Surname              varchar(255) NULL,
       GivenName            varchar(255) NULL,
       SequenceNumber       smallint NOT NULL,
       RoleDescription		 varchar(128) NULL,
       Type                 smallint NOT NULL,
       EmailAddress         varchar(64) NULL,
       TelNumber            varchar(60) NULL,
       TelExtension         varchar(60) NULL,
       FaxNumber            varchar(60) NULL,
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
       AddressLine1         varchar(255) NULL,
       AddressLine2         varchar(255) NULL,
       AddressLine3         varchar(255) NULL,
       City                 varchar(255) NULL,
       State_Province       varchar(128) NULL,
       Zip_PostalCode       varchar(128) NULL,
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
       ServiceName          varchar(128) NOT NULL,
       B2BInterface         varchar(512) NOT NULL,
       B2BService           varchar(512) NOT NULL,
       RemoteLocation       varchar(128) NULL,
       RemoteUser           varchar(32) NULL,
       RemotePassword       varchar(32) NULL,
       Scheduled            int
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
       TransportStatus      varchar(60) NULL,
       TransportStatusMessage varchar(512) NULL,
       TransportTime        int NULL,
       DocID                char(24) NULL,
       OutputData           image NULL,
       ServiceName          varchar(128) NULL,
       RetryFactor          int NULL,
       TypeData        	    image NULL,
       JobType		    varchar(20) NULL,
       QueueName      varchar(254) NULL       
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
       Protocol             varchar(64) NOT NULL,
       Host                 varchar(64) NULL,
       PrimaryAddr          int NOT NULL,
       Port                 varchar(6) NULL,
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
       Description          varchar(255) NOT NULL
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
       RuleDescription      varchar(255) NULL,
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
       PreferredProtocol    varchar(64) NULL,
       PollingFrequency     float NULL,
       DeliveryMaxRetries   smallint NULL,
       DeliveryRetryWait    int NULL,
       PollingProtocol      varchar(64) NULL,
       RetryFactor	    int NULL,
       DeliveryQueue    varchar(254) NULL
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
   ScriptName  varchar(255) NOT NULL,
   ScriptIndex int,
   ScriptData  image
);

ALTER TABLE ConversationScript
       ADD CONSTRAINT pk_ConvScr_ScriptName PRIMARY KEY (ScriptName)

go

--********************************************************************

CREATE TABLE Process(
	InstanceID			varchar(300) NOT NULL,
	ParentInstanceID	varchar(300),
	ProcessKey			varchar(64) NOT NULL,
	ProcessLabel		varchar(512),
	ProcessVersion		varchar(64),
	Status				varchar(40) NOT NULL,
  DeploymentVersion integer,
	TimeCreated			datetime NOT NULL,
	LastModified		datetime
);

ALTER TABLE Process ADD CONSTRAINT pk_Process_InstId PRIMARY KEY(InstanceID) ;

ALTER TABLE Process ADD CONSTRAINT fk_proc_PInID_proc
	FOREIGN KEY(ParentInstanceID) REFERENCES Process ;

--********************************************************************

CREATE TABLE ProcessStep(
	InstanceID			varchar(300) NOT NULL,
	StepID				varchar(128) NOT NULL,
	StepLabel			varchar(128),
	Status				varchar(40) NOT NULL,
	System				varchar(10) NOT NULL,
	CurrentTry			integer NOT NULL,
  TargetStepIDs   varchar(255),
  Server          varchar(128),
  Component       varchar(128),
	TimeCreated			datetime NOT NULL,
	LastModified		datetime
);

ALTER TABLE ProcessStep ADD CONSTRAINT pk_PStep_InId_StID PRIMARY KEY(InstanceID, StepID);

ALTER TABLE ProcessStep ADD CONSTRAINT fk_PStep_InId_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process ;

--********************************************************************

CREATE TABLE CustomProcessData(
	InstanceID			varchar(300) NOT NULL,
	StepID				varchar(128) NOT NULL,
	DocumentID			varchar(128) NOT NULL,
	FieldName			varchar(128) NOT NULL,
	DocumentName		varchar(128),
	StringValue			varchar(4000),
	NumberValue			float,
	DateValue			datetime
);

ALTER TABLE CustomProcessData ADD CONSTRAINT pk_CustomProcData
	PRIMARY KEY(InstanceID, StepID, DocumentID, FieldName) ;

ALTER TABLE CustomProcessData ADD CONSTRAINT fk_CusPD_InID_StID
	FOREIGN KEY(InstanceID,StepID) REFERENCES ProcessStep ;

--********************************************************************

CREATE TABLE TNProcess(
	InstanceID			varchar(300) NOT NULL,
	ScriptName			varchar(255) NOT NULL,
	TNStatus				varchar(40) NOT NULL,
	UserInstanceID		varchar(150),
	UserInstanceID2	varchar(150),
	CurrentStep			varchar(64),
	Timeout				datetime,
	LastModified		datetime
);

CREATE INDEX idx_TNP_UserInID ON TNProcess
(
       UserInstanceID,
       UserInstanceID2
);

CREATE INDEX idx_TNP_TNStatus ON TNProcess
(
		 TNStatus
);

ALTER TABLE TNProcess ADD CONSTRAINT pk_TNProc_InstID
	PRIMARY KEY(InstanceID) ;

ALTER TABLE TNProcess ADD CONSTRAINT fk_TNPro_InID_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process ;

--********************************************************************

CREATE TABLE TNRoleBinding(
	InstanceID			varchar(300) NOT NULL,
	RoleName				varchar(128) NOT NULL,
	PartnerID			char(24),
	RoleType				integer NOT NULL
);

ALTER TABLE TNRoleBinding ADD CONSTRAINT pk_TNRB_InID_RName
	PRIMARY KEY(InstanceID, RoleName);

ALTER TABLE TNRoleBinding ADD CONSTRAINT fk_TNRB_InID_Proc
	FOREIGN KEY(InstanceID) REFERENCES Process ;

ALTER TABLE TNRoleBinding
       ADD CONSTRAINT fk_RBind_PtrId_Ptr FOREIGN KEY (PartnerID)
                             REFERENCES Partner ;

--********************************************************************

CREATE TABLE ActivityLog(
       RelatedDocID         char(24),
       EntryTimestamp       datetime NOT NULL,
       EntryType            int NOT NULL,
       EntryClass           varchar(20),
       BriefMessage         varchar(240) NOT NULL,
       RelatedPartnerID     char(24),
       RelatedInstanceID	 varchar(300),
       RelatedStepID			 varchar(128),
       B2BUser              varchar(20),
       FullMessage          varchar(1024)
);

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
       RelatedDocID
);

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
       RelatedPartnerID
);

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                             REFERENCES Partner;

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc;

ALTER TABLE ActivityLog
       ADD CONSTRAINT fk_ActLog_RelatedInstId_Conv FOREIGN KEY (RelatedInstanceID)
                             REFERENCES Process ;

--********************************************************************

CREATE TABLE DeliveryQueue (
	QueueName            varchar(254) NOT NULL,
	QueueType            varchar(12) NOT NULL,
	QueueState           varchar(12) NOT NULL,
	Schedule             image NOT NULL
)
go

CREATE INDEX idx_DeliQueue_QueueType ON DeliveryQueue
(
  QueueType
)
go

ALTER TABLE DeliveryQueue
       ADD CONSTRAINT pk_DeliQueue_QueueName PRIMARY KEY (QueueName)
go

--********************************************************************

CREATE TABLE SecurityData
(
	DataID					char(24) NOT NULL,
	OwnerID					char(24) NOT NULL,
	CertificateData		image NULL
)
go

CREATE INDEX Idx_SecDat_OwnrId ON SecurityData( OwnerID )
go

ALTER TABLE SecurityData ADD CONSTRAINT pk_SecDat_DataId
	PRIMARY KEY ( DataID )
go

ALTER TABLE SecurityData ADD CONSTRAINT fk_SecDat_OwnrId_Ptnr
	FOREIGN KEY ( OwnerID ) REFERENCES Partner( PartnerID )
go

--********************************************************************

CREATE TABLE SecurityAgreement
(
	AgreementID				char(24) NOT NULL,
	SenderID				char(24) NULL,
	ReceiverID				char(24) NULL,
	SecurityUsage			varchar(20) NOT NULL,
	SecurityDataID			char(24) NOT NULL
)
go

CREATE INDEX Idx_SecAgr_SndrId ON SecurityAgreement( SenderID )
go

CREATE INDEX Idx_SecAgr_RcvrId ON SecurityAgreement( ReceiverID )
go

CREATE INDEX Idx_SecAgr_Usg ON SecurityAgreement( SecurityUsage )
go

ALTER TABLE SecurityAgreement ADD CONSTRAINT pk_SecAgr_AgrId
	PRIMARY KEY ( AgreementID )
go

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_SndrId_Ptnr
	FOREIGN KEY ( SenderID ) REFERENCES Partner( PartnerID )
go

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_RcvrId_Ptnr
	FOREIGN KEY ( ReceiverID ) REFERENCES Partner( PartnerID )
go

ALTER TABLE SecurityAgreement ADD CONSTRAINT fk_SecAgr_SecDatId_SecDat
	FOREIGN KEY ( SecurityDataID ) REFERENCES SecurityData( DataID )
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
-- BI Tables
--********************************************************************
CREATE TABLE ProcessDefinition (
	ProcessKey		varchar(64) NOT NULL,
	ProcessLabel		varchar(255),
	OID			varchar(128),
	ProcessPath		varchar(512),	
	Description		varchar(512),
	Version			varchar(20),
	CreatedBy		varchar(64),
	LastModified		datetime,
	SingleStop		integer NOT NULL,
	Icon			image,
	ProcessImage		image,
	DeploymentTime		datetime,
	DeploymentVersion	integer NOT NULL,
	StopCount		integer
)
go

ALTER TABLE ProcessDefinition
	ADD CONSTRAINT pk_PDef_ProcessKey PRIMARY KEY (ProcessKey, DeploymentVersion)
go

--********************************************************************

CREATE TABLE StepDefinition(
	ProcessKey		varchar(64) NOT NULL,
	StepID			varchar(128) NOT NULL,
	StepLabel		varchar(128),
	Type			integer,
	Icon			image,
	Description		varchar(512),
	IS_Start		integer,
	IS_Stop			integer,
	Icon_X			integer,
	Icon_Y			integer,
	Icon_Width		integer,
	Icon_Height		integer,
	DeploymentVersion	integer NOT NULL,
	Server			varchar(128),
	Component		varchar(128),
	SubprocessKey		varchar(150),
	InlineStepID		varchar(128)
)
go

ALTER TABLE StepDefinition
      ADD CONSTRAINT pk_StepDef_StepID PRIMARY KEY (ProcessKey, StepID, DeploymentVersion)
go

--********************************************************************

CREATE TABLE StepTransitionDefinition(
	ProcessKey		varchar(64) NOT NULL,
	SourceStepID		varchar(128) NOT NULL,
	TargetStepID		varchar(128) NOT NULL,
	SourceX			integer,
	SourceY			integer,
	TargetX			integer,
	TargetY			integer,
	VisualType		varchar(10),
	Type			varchar(10),
	Label			varchar(255),
	Condition		varchar(255),
	DeploymentVersion	integer NOT NULL
)
go

ALTER TABLE StepTransitionDefinition
      ADD CONSTRAINT pk_StepTranDef PRIMARY KEY (ProcessKey, SourceStepID, TargetStepID, DeploymentVersion)

go

--********************************************************************

CREATE TABLE CustomFieldDefinition(
	ProcessKey		varchar(64) NOT NULL,
	StepID			varchar(128) NOT NULL,
	DocumentName		varchar(128) NOT NULL,
	FieldName		varchar(128) NOT NULL,
	FieldType		varchar(20),
	DeploymentVersion	integer NOT NULL
)
go

ALTER TABLE CustomFieldDefinition
      ADD CONSTRAINT pk_CustomFieldDef PRIMARY KEY (ProcessKey, StepID, DeploymentVersion, DocumentName, FieldName)

go

--********************************************************************

CREATE TABLE SchemaDefinition (
	Version			varchar(20),
	CreationDate		datetime,
	CreatingSystem		varchar(20)
)
go

--********************************************************************

CREATE TABLE ProcessPermission (
	GroupLabel		varchar(255) NOT NULL,
	ProcessKey		varchar(64) NOT NULL,
	ProcessLabel		varchar(255) NOT NULL
)
go

ALTER TABLE ProcessPermission
	ADD CONSTRAINT pk_ProcPerm_Group_Key PRIMARY KEY (GroupLabel, ProcessKey)

go


--********************************************************************
-- Enterprise Logger Adapter Tables
--********************************************************************

CREATE TABLE ent_object (
	obj_id numeric(18, 0) IDENTITY (1, 1) NOT NULL ,
	object_name char(256) NOT NULL
);

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDObject ON ent_object
(
       object_name                       
);

ALTER TABLE ent_object ADD CONSTRAINT pk_entobj_objid PRIMARY KEY NONCLUSTERED (obj_id) ;

--********************************************************************

CREATE TABLE ent_component (
	obj_id numeric(18, 0) NOT NULL ,
	comp_id numeric(18, 0) IDENTITY (1, 1) NOT NULL ,
	component char(256) NOT NULL 
);

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDComponent ON ent_component
(
       obj_id                            ,
       component                         
);		

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDComponentSerial ON ent_component
(
       comp_id                           
) ;

ALTER TABLE ent_component ADD CONSTRAINT pk_entcomp_objid_compid 
		PRIMARY KEY NONCLUSTERED (obj_id, comp_id) ;

ALTER TABLE ent_component ADD CONSTRAINT 
		fk_entcomp_objid_entobj FOREIGN KEY(obj_id) REFERENCES ent_object;

--********************************************************************

CREATE TABLE ent_work_unit (
	work_unit_id numeric(18, 0) IDENTITY (1, 1) NOT NULL ,
	client_id char(128) NOT NULL ,
	adapter_type char(128) NULL ,
	class_name char(512) NOT NULL
);

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDWorkUnit ON ent_work_unit
(
       client_id                         ,
       class_name                        
);

ALTER TABLE ent_work_unit ADD CONSTRAINT pk_entworkunit_workunitid 
	PRIMARY KEY NONCLUSTERED (work_unit_id);

--********************************************************************

CREATE TABLE ent_integration (
	obj_id numeric(18, 0) NOT NULL ,
	comp_id numeric(18, 0) NOT NULL ,
	tranx_id numeric(28, 0) IDENTITY (1, 1) NOT NULL ,
	integration_id char(300) NOT NULL
);

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDIntegration ON ent_integration
(
       obj_id                            ,
       comp_id                           ,
       integration_id                    
) ;

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDIntegrationSerial ON ent_integration
(
       tranx_id                          
) ;

ALTER TABLE ent_integration ADD CONSTRAINT
		pk_entintg_objid_compid_tranid PRIMARY KEY NONCLUSTERED (obj_id, comp_id, tranx_id) ;

ALTER TABLE ent_integration ADD CONSTRAINT  
		fk_entint_objid_compid_entcomp FOREIGN KEY(obj_id, comp_id) REFERENCES ent_component ;

--********************************************************************

CREATE TABLE ent_activation (
	obj_id numeric(18, 0) NOT NULL ,
	comp_id numeric(18, 0) NOT NULL ,
	tranx_id numeric(28, 0) NOT NULL ,
	work_unit_id numeric(18, 0) NOT NULL ,
	event_type_name char (256) NOT NULL ,
	integration_id char(300) NOT NULL ,
	restart_count numeric(18, 0) NOT NULL ,
	timestamp datetime NOT NULL ,
	end_flag char(1) NOT NULL ,
	end_timestamp datetime NULL ,
	event image NULL ,
	seq_number numeric(28, 0) NULL ,
	event_id char(24) NOT NULL
);

CREATE NONCLUSTERED INDEX ENT_XIDActivationTranxId on ent_activation
(
       tranx_id                          
) ;

CREATE NONCLUSTERED INDEX ENT_XIDActivation on ent_activation
(
       tranx_id                          ,
       work_unit_id                      
) ;

CREATE NONCLUSTERED INDEX ENT_XIDActivationStatus on ent_activation
(
       tranx_id                          ,
       end_flag                          
) ;

ALTER TABLE ent_activation ADD CONSTRAINT pk_entact_oid_cid_tid_wid_etyp 
		PRIMARY KEY NONCLUSTERED (obj_id, comp_id, tranx_id, work_unit_id, event_type_name) ;

ALTER TABLE ent_activation ADD CONSTRAINT fk_entact_oid_cid_tid_entintg
		FOREIGN KEY(obj_id, comp_id, tranx_id) REFERENCES ent_integration ;

ALTER TABLE ent_activation ADD CONSTRAINT fk_entact_workunitid_entwunit
		FOREIGN KEY(work_unit_id) REFERENCES ent_work_unit ;

--********************************************************************

CREATE TABLE ent_message_log (
	obj_id numeric(18, 0) NOT NULL ,
	comp_id numeric(18, 0) NOT NULL ,
	tranx_id numeric(28, 0) NOT NULL ,
	work_unit_id numeric(18, 0) NOT NULL ,
	event_type_name char(256) NOT NULL ,
	msg_nbr numeric(18, 0) IDENTITY (1, 1) NOT NULL ,
	integration_id char(300) NOT NULL ,
	timestamp datetime NOT NULL ,
	severity int NULL ,
	msg_content varchar(2000) NULL
);

CREATE UNIQUE NONCLUSTERED INDEX ENT_XUIDMsgLogSerial ON ent_message_log
(
       msg_nbr                           
) ;

CREATE NONCLUSTERED INDEX ENT_XIDMessage on ent_message_log
(
       tranx_id                          
) ;

CREATE NONCLUSTERED INDEX ENT_XIDMessageSeverity on ent_message_log
(
       tranx_id                          ,
       event_type_name                   ,
       severity
) ;

ALTER TABLE ent_message_log ADD CONSTRAINT pk_entmsglog PRIMARY KEY NONCLUSTERED 
	(obj_id, comp_id, tranx_id, work_unit_id, event_type_name, msg_nbr) ;

ALTER TABLE ent_message_log ADD CONSTRAINT fk_entmsglog_to_entactivation
	FOREIGN KEY(obj_id, comp_id, tranx_id, work_unit_id, event_type_name) REFERENCES ent_activation ;

--********************************************************************

CREATE TABLE ent_activation_custom (
	obj_id numeric(18, 0) NOT NULL ,
	comp_id numeric(18, 0) NOT NULL ,
	tranx_id numeric(28, 0) NOT NULL ,
	work_unit_id numeric(18, 0) NOT NULL ,
	event image NULL ,
	field_name char(128) NULL ,
	string_value char(256) NULL ,
	number_value float(53) NULL ,
	date_value datetime NULL
);

CREATE NONCLUSTERED INDEX ENT_XIDActivationCustom on ent_activation_custom
(
       obj_id                            ,
       comp_id                           ,
       tranx_id                          ,
       work_unit_id                      
) ;

ALTER TABLE ent_activation_custom ADD CONSTRAINT fk_entactcust_to_entinteg
	FOREIGN KEY(obj_id, comp_id, tranx_id) REFERENCES ent_integration ;

ALTER TABLE ent_activation_custom ADD CONSTRAINT fk_entactcust_wunitid_entwunit 
	FOREIGN KEY(work_unit_id) REFERENCES ent_work_unit ;

--********************************************************************
-- insert BI schema version
--********************************************************************
INSERT INTO SchemaDefinition (Version, CreationDate, CreatingSystem)
        VALUES ('1', CURRENT_TIMESTAMP, 'BI') ;

--********************************************************************

commit tran
go

--********************************************************************

