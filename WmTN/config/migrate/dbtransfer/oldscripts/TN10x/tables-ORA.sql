
--********************************************************************
CREATE TABLE Partner (
       ParentPartnerID      CHAR(24) NULL,
       PartnerID            CHAR(24) NOT NULL,
       CorporationName      VARCHAR2(64) NOT NULL,
       OrgUnitName          VARCHAR2(64) NULL,
       Deleted              SMALLINT NOT NULL,
       Status               VARCHAR2(12) NOT NULL,
       Type                 CHAR(12) NOT NULL,
       Self                 SMALLINT NOT NULL,
       TNVersion            VARCHAR2(20) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_Ptnr_ParentPtnrId ON Partner
(
       ParentPartnerID                ASC
);

CREATE INDEX idx_Ptnr_CorpName_OrgUnitName ON Partner
(
       CorporationName                ASC,
       OrgUnitName                    ASC
);


ALTER TABLE Partner
       ADD  ( CONSTRAINT pk_Ptnr_PtnrId PRIMARY KEY (PartnerID) ) ;


ALTER TABLE Partner
       ADD  ( CONSTRAINT fk_Ptnr_ParentPtnrId_Ptnr FOREIGN KEY (ParentPartnerID)
                             REFERENCES Partner ) ;

--********************************************************************

CREATE TABLE BizDocAttributeDef (
      AttributeName        VARCHAR2(64) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      AttributeDescription VARCHAR2(256) NULL,
      AttributeType        VARCHAR2(10) NOT NULL,
      Deleted              SMALLINT NOT NULL,
      LastModified         DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE BizDocAttributeDef
      ADD  ( CONSTRAINT pk_BizDocAttDef_AttId PRIMARY KEY (AttributeID) ) ;
      
--********************************************************************

CREATE TABLE BizDocTypeDef (
      TypeName             VARCHAR2(64) NOT NULL,
      TypeID               CHAR(24) NOT NULL,
      TypeDescription      VARCHAR2(256) NULL,
      TypeData             BLOB NOT NULL,
      Deleted              SMALLINT NOT NULL,
      LastModified         DATE NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

ALTER TABLE BizDocTypeDef
       ADD  ( CONSTRAINT pk_BizDocTypeDef_TypeId PRIMARY KEY (TypeID) ) ;

--********************************************************************

CREATE TABLE BinaryType (
      Type                 SMALLINT NOT NULL,
      Description          VARCHAR2(24) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;


ALTER TABLE BinaryType
      ADD  ( CONSTRAINT pk_BinaryType_Type PRIMARY KEY (Type) ) ;
      
      
--********************************************************************

CREATE TABLE ContactType (
      Type                 SMALLINT NOT NULL,
      Description          VARCHAR2(24) NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

ALTER TABLE ContactType
       ADD  ( CONSTRAINT pk_ContType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE BizDoc (
      DocID                CHAR(24) NOT NULL,
      DocTypeID            CHAR(24) NULL,
      SenderID             CHAR(24) NOT NULL,
      ReceiverID           CHAR(24) NOT NULL,
      NativeID             VARCHAR2(100) NULL,
      DocTimestamp         DATE NOT NULL,
      RoutingStatus        VARCHAR2(20) NOT NULL,
      GroupID              VARCHAR2(100) NULL,
      ConversationID       VARCHAR2(100) NULL,
      UserStatus           VARCHAR2(100) NULL,
      LastModified         DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;

CREATE INDEX idx_BizDoc_DocTypeId ON BizDoc
(
      DocTypeID            ASC
);

CREATE INDEX idx_BizDoc_SenderId ON BizDoc
(
      SenderID             ASC
);

CREATE INDEX idx_BizDoc_ReceiverId ON BizDoc
(
      ReceiverID           ASC
);


ALTER TABLE BizDoc
      ADD  ( CONSTRAINT pk_BizDoc_DocId PRIMARY KEY (DocID) ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_ReceiverId_Ptnr FOREIGN KEY (ReceiverID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_SenderId_Ptnr FOREIGN KEY (SenderID)
                             REFERENCES Partner ) ;


ALTER TABLE BizDoc
       ADD  ( CONSTRAINT fk_BizDoc_DocTyId_BizDocTypDef FOREIGN KEY (DocTypeID)
                             REFERENCES BizDocTypeDef ) ;

--********************************************************************

CREATE TABLE BizDocArchive (
      DocID                CHAR(24) NOT NULL,
      ArchiveTimestamp     DATE DEFAULT SYSDATE NOT NULL,
      DocTimestamp         DATE NOT NULL,
      SenderCorp           VARCHAR2(64) NOT NULL,
      DocTypeName          VARCHAR2(64) NOT NULL,
      ReceiverCorp         VARCHAR2(64) NOT NULL,
      Content              BLOB NOT NULL,
      SenderOrgUnit        VARCHAR2(64) NULL,
      ReceiverOrgUnit      VARCHAR2(64) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;


ALTER TABLE BizDocArchive
      ADD  ( CONSTRAINT pk_BizDocArc_DocId PRIMARY KEY (DocID) ) ;
      

--********************************************************************

CREATE TABLE BizDocAttribute (
      DocID                CHAR(24) NOT NULL,
      AttributeID          CHAR(24) NOT NULL,
      StringValue          VARCHAR2(256) NULL,
      NumberValue          FLOAT NULL,
      DateValue            DATE NULL
)
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocAtt_AttId ON BizDocAttribute
(
      AttributeID          ASC
);

CREATE INDEX idx_BizDocAtt_DocId ON BizDocAttribute
(
      DocID               ASC
);


ALTER TABLE BizDocAttribute
      ADD  ( CONSTRAINT pk_BizDocAtt_DocId_AttId PRIMARY KEY (DocID, AttributeID) ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocAttribute
       ADD  ( CONSTRAINT fk_BizDocAtt_AttId_BizDocAtDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--********************************************************************

CREATE TABLE BizDocContent (
      DocID                CHAR(24) NOT NULL,
      Content              BLOB NOT NULL,
      ContentLength        NUMBER NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE BizDocContent
      ADD ( CONSTRAINT pk_BizDocCont_DocId PRIMARY KEY (DocID) ) ;

ALTER TABLE BizDocContent
       ADD  ( CONSTRAINT fk_BizDocCont_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocRelationship (
       DocID                CHAR(24) NOT NULL,
       RelatedDocID         CHAR(24) NOT NULL,
       Relationship         VARCHAR2(80) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_BizDocRel_RelatedDocId ON BizDocRelationship
(
      RelatedDocID                   ASC
);

CREATE INDEX idx_BizDocRel_DocId ON BizDocRelationship
(
       DocID                          ASC
);


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT pk_BizDocRel_DocId_RelatDocId PRIMARY KEY (DocID, RelatedDocID) ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;


ALTER TABLE BizDocRelationship
       ADD  ( CONSTRAINT fk_BizDocRel_RelatDocId_BizDoc FOREIGN KEY (RelatedDocID)
                             REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE BizDocTypeAttribute (
      AttributeID          CHAR(24) NOT NULL,
      TypeID               CHAR(24) NOT NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_BizDocTypeAtt_AttId ON BizDocTypeAttribute
(
      AttributeID                    ASC
);

CREATE INDEX idx_BizDocTypeAtt_TypeId ON BizDocTypeAttribute
(
      TypeID                         ASC
);

ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT pk_BizDocTypeAtt_AttId_TypeId PRIMARY KEY (AttributeID, TypeID) ) ;

       
ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_TypId_BDocTypDef FOREIGN KEY (TypeID)
                             REFERENCES BizDocTypeDef ) ;


ALTER TABLE BizDocTypeAttribute
       ADD  ( CONSTRAINT fk_BDocTypAtt_AttId_BDocAttDef FOREIGN KEY (AttributeID)
                             REFERENCES BizDocAttributeDef ) ;

--*******************************************************************

CREATE TABLE ActivityLog (
      RelatedDocID         CHAR(24) NULL,
      EntryTimestamp       DATE NOT NULL,
      EntryType            INTEGER NOT NULL,
      EntryClass           VARCHAR2(20) NULL,
      BriefMessage         VARCHAR2(80) NOT NULL,
      RelatedPartnerID     CHAR(24) NULL,
      B2BUser              VARCHAR2(20) NULL,
      FullMessage          VARCHAR2(1024) NULL
) 
   STORAGE( MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_ActLog_RelatedDocId ON ActivityLog
(
      RelatedDocID         ASC
);

CREATE INDEX idx_ActLog_RelatedPtnrId ON ActivityLog
(
      RelatedPartnerID     ASC
);

ALTER TABLE ActivityLog
      ADD  ( CONSTRAINT fk_ActLog_RelatedPtnrId_Ptnr FOREIGN KEY (RelatedPartnerID)
                  REFERENCES Partner ) ;


ALTER TABLE ActivityLog
      ADD  ( CONSTRAINT fk_ActLog_RelatedDocId_BizDoc FOREIGN KEY (RelatedDocID)
                     REFERENCES BizDoc ) ;

--********************************************************************

CREATE TABLE Contact (
      PartnerID            CHAR(24) NOT NULL,
      Surname              VARCHAR2(40) NULL,
      ContactID            CHAR(24) NOT NULL,
      SequenceNumber       SMALLINT NOT NULL,
      GivenName            VARCHAR2(40) NOT NULL,
      Role                 VARCHAR2(64) NULL,
      Type                 SMALLINT NOT NULL,
      EmailAddress         VARCHAR2(64) NULL,
      TelNumber            VARCHAR2(20) NULL,
      TelExtension         VARCHAR2(20) NULL,
      FaxNumber            VARCHAR2(20) NULL,
      PagerNumber          VARCHAR2(20) NULL
)
   STORAGE (MAXEXTENTS UNLIMITED)
;

CREATE INDEX idx_Cont_PtnrId ON Contact
(
       PartnerID                      ASC
);

ALTER TABLE Contact
       ADD  ( CONSTRAINT pk_Cont_PtnrId_ContId PRIMARY KEY (PartnerID, ContactID) ) ;

ALTER TABLE Contact
       ADD  ( CONSTRAINT fk_Cont_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--*******************************************************************

CREATE TABLE Address (
      AddressID            CHAR(24) NOT NULL,
      PartnerID            CHAR(24) NULL,
      ContactID            CHAR(24) NULL,
      AddressLine1         VARCHAR2(50) NULL,
      AddressLine2         VARCHAR2(50) NULL,
      AddressLine3         VARCHAR2(50) NULL,
      City                 VARCHAR2(50) NULL,
      State_Province       VARCHAR2(20) NULL,
      Zip_PostalCode       VARCHAR2(12) NULL,
      Country              VARCHAR2(18) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED) 
;

CREATE INDEX idx_Address_PtnrId_ContId ON Address
(
      PartnerID            ASC,
      ContactID            ASC
);

CREATE INDEX idx_Address_PtnrId ON Address
(
      PartnerID            ASC
);


ALTER TABLE Address
      ADD  ( CONSTRAINT pk_Address_AddressId PRIMARY KEY (AddressID) ) ;


ALTER TABLE Address
       ADD  ( CONSTRAINT fk_Address_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;


ALTER TABLE Address
       ADD  ( CONSTRAINT fk_Address_PtnrId_ContId_Cont FOREIGN KEY (PartnerID, ContactID)
                             REFERENCES Contact) ;
                             
--********************************************************************

CREATE TABLE DeliveryService (
      ServiceName          VARCHAR2(48) NOT NULL,
      B2BInterface         VARCHAR2(20) NOT NULL,
      B2BService           VARCHAR2(20) NOT NULL,
      RemoteLocation       VARCHAR2(50) NULL,
      RemoteUser           VARCHAR2(20) NULL,
      RemotePassword       VARCHAR2(20) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE DeliveryService
       ADD  ( CONSTRAINT pk_DeliServ_ServName PRIMARY KEY (ServiceName) ) ;
                             
--********************************************************************

CREATE TABLE DeliveryJob (
      JobID                CHAR(24) NOT NULL,
      ServerID             VARCHAR2(50) NOT NULL,
      TimeCreated          DATE NULL,
      TimeUpdated          DATE NULL,
      JobStatus            VARCHAR2(20) NULL,
      TimeToWait           NUMBER NULL,
      Retries              NUMBER NULL,
      RetryLimit           NUMBER NULL,
      TransportStatus      VARCHAR2(20) NULL,
      TransportStatusMessage VARCHAR2(80) NULL,
      TransportTime        NUMBER NULL,
      DocID                CHAR(24) NULL,
      OutputData           BLOB NULL,
      ServiceName          VARCHAR2(48) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_DeliJob_ServName ON DeliveryJob
(
       ServiceName                    ASC
);

CREATE INDEX idx_DeliJob_DocId ON DeliveryJob
(
       DocID                          ASC
);

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT pk_DeliJob_JobId PRIMARY KEY (JobID) ) ;

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT fk_DeliJob_DocId_BizDoc FOREIGN KEY (DocID)
                             REFERENCES BizDoc ) ;

ALTER TABLE DeliveryJob
       ADD  ( CONSTRAINT fk_DeliJob_ServName_DeliServ FOREIGN KEY (ServiceName)
                             REFERENCES DeliveryService ) ;

--********************************************************************

CREATE TABLE Destination (
       PartnerID            CHAR(24) NOT NULL,
       Protocol             CHAR(8) NOT NULL,
       Host                 VARCHAR2(64) NULL,
       PrimaryAddr          INTEGER NOT NULL,
       Port                 VARCHAR2(6) NULL,
       Location             VARCHAR2(128) NULL,
       UserName             VARCHAR2(24) NULL,
       Password             VARCHAR2(24) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_Dest_PtnrId ON Destination
(
       PartnerID                      ASC
);


ALTER TABLE Destination
       ADD  ( CONSTRAINT pk_Dest_PtnrId_Prot_PrimAddr PRIMARY KEY (PartnerID, Protocol, PrimaryAddr) ) ;

ALTER TABLE Destination
       ADD  ( CONSTRAINT fk_Dest_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE IDType (
       Type                 INTEGER NOT NULL,
       Description          VARCHAR2(128) NOT NULL
)
   STORAGE ( MAXEXTENTS UNLIMITED )
;


ALTER TABLE IDType
       ADD  ( CONSTRAINT pk_IdType_Type PRIMARY KEY (Type) ) ;


--********************************************************************

CREATE TABLE PartnerBinary (
       PartnerID            CHAR(24) NOT NULL,
       Type                 VARCHAR2(20) NOT NULL,
       Value                BLOB NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_PtnrBin_PtnrId ON PartnerBinary
(
       PartnerID                      ASC
);


ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT pk_PtnrBin_PtnrId_Type PRIMARY KEY (PartnerID, Type) ) ;

ALTER TABLE PartnerBinary
       ADD  ( CONSTRAINT fk_PtnrBin_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE PartnerID (
       InternalID           CHAR(24) NOT NULL,
       ExternalID           CHAR(35) NOT NULL,
       IDType               INTEGER NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

CREATE INDEX idx_PtnrIdTbl_InternalId ON PartnerID
(
       InternalID                     ASC
);


ALTER TABLE PartnerID
       ADD  ( CONSTRAINT pk_PtnrIdTbl_ExternalId_IdType PRIMARY KEY (ExternalID, IDType) ) ;
       
ALTER TABLE PartnerID
       ADD  ( CONSTRAINT fk_PtnrIdTbl_InternalId_Ptnr FOREIGN KEY (InternalID)
                             REFERENCES Partner) ;

--********************************************************************

CREATE TABLE ProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       Name                 CHAR(32) NULL,
       Required             SMALLINT NOT NULL,
       Registration         SMALLINT NOT NULL,
       ValidValues          VARCHAR2(4000) NULL,
       DefaultValue         VARCHAR2(128) NULL,
       ProfileTbl           VARCHAR2(20) NULL,
       DataType             VARCHAR2(10) NULL,
       ProfileCol           VARCHAR2(20) NULL,
       Deleted              SMALLINT NOT NULL,
       GroupID              SMALLINT NOT NULL,
       Description          VARCHAR2(1024) NULL,
       MaxLength            NUMBER NULL,
       Display              SMALLINT NOT NULL
);

CREATE INDEX idx_ProfFld_ProfTbl_ProfCol ON ProfileField
(
       ProfileTbl                     ASC,
       ProfileCol                     ASC
);

CREATE INDEX idx_ProfFld_Name ON ProfileField
(
       Name                           ASC
);


ALTER TABLE ProfileField
       ADD  ( CONSTRAINT pk_ProfFld_ProfFldId PRIMARY KEY (ProfileFieldID) ) ;

--********************************************************************

CREATE TABLE PartnerProfileField (
       ProfileFieldID       CHAR(24) NOT NULL,
       ValueBinary          BLOB NULL,
       PartnerID            CHAR(24) NOT NULL,
       ValueString          VARCHAR2(4000) NULL
);

CREATE INDEX idx_PtnrProFld_ProFldId ON PartnerProfileField
(
       ProfileFieldID                 ASC
);

CREATE INDEX idx_PtnrProFld_PtnrId ON PartnerProfileField
(
       PartnerID                      ASC
);


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT pk_PtnrProFld_PtnrId_ProFldId PRIMARY KEY (PartnerID, ProfileFieldID) ) ;


ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_ProFldId_ProFld FOREIGN KEY (ProfileFieldID)
                             REFERENCES ProfileField ) ;

ALTER TABLE PartnerProfileField
       ADD  ( CONSTRAINT fk_PtnrProFld_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;
                             
--********************************************************************

CREATE TABLE ProcessingRule (
       RuleIndex            NUMBER NOT NULL,
       RuleDescription      VARCHAR2(256) NULL,
       RuleName             VARCHAR2(64) NOT NULL,
       RuleData             BLOB NULL,
       LastModified         DATE NULL,
       Disabled             SMALLINT NOT NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;

ALTER TABLE ProcessingRule
       ADD  ( CONSTRAINT pk_ProcessingRule_RuleIndex PRIMARY KEY (RuleIndex) ) ;


--********************************************************************

CREATE TABLE Remote (
       PartnerID            CHAR(24) NOT NULL,
       Certificate          VARCHAR2(255) NULL,
       CACertificate        VARCHAR2(255) NULL,
       RemoteStatus         VARCHAR2(12) NULL,
       PrivateKey           VARCHAR2(255) NULL,
       PreferredProtocol    VARCHAR2(8) NULL,
       PollingFrequency     FLOAT NULL,
       DeliveryMaxRetries   SMALLINT NULL,
       DeliveryRetryWait    INTEGER NULL,
       PollingProtocol      VARCHAR2(8) NULL
)
   STORAGE( MAXEXTENTS UNLIMITED )
;


ALTER TABLE Remote
       ADD  ( CONSTRAINT pk_Remote_PtnrId PRIMARY KEY (PartnerID) ) ;

ALTER TABLE Remote
       ADD  ( CONSTRAINT fk_Remote_PtnrId_Ptnr FOREIGN KEY (PartnerID)
                             REFERENCES Partner) ;
--********************************************************************

CREATE TABLE TNModelVersion (
       MajorVersion         NUMBER NOT NULL,
       MinorVersion         NUMBER NOT NULL
);


ALTER TABLE TNModelVersion
       ADD  ( CONSTRAINT pk_TNModelVer_MajVer_MinorVer PRIMARY KEY (MajorVersion, MinorVersion) ) ;


--********************************************************************
