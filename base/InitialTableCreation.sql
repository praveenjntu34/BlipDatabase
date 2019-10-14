

--CREATE DATABASE BlipProd


CREATE TABLE PersonType(
 PersonTypeId int IDENTITY(1,1) PRIMARY KEY
,PersonTypeName nvarchar(50)
)

INSERT INTO PersonType VALUES 
 ('SuperAdmin')
,('InstitutionAdmin')
,('BranchAdmin')
,('Parent')
,('Instructor')

CREATE TABLE InstitutionType(
 InstitutionTypeId int IDENTITY(1,1) PRIMARY KEY
,InstitutionTypeName nvarchar(50)
)

INSERT INTO InstitutionType VALUES 
 ('College')
,('School')

CREATE TABLE PostType(
 PostTypeId int IDENTITY(1,1) PRIMARY KEY
,PostTypeName nvarchar(50)
)

INSERT INTO PostType VALUES 
 ('Text')
,('Image')
,('Attachment')

CREATE TABLE Tenant(
 TenantId int IDENTITY(1,1) 
,TenantName nvarchar(150)

,PRIMARY KEY (TenantId)
)

CREATE TABLE Institution(
 InstitutionId int IDENTITY(1,1) 
,InstitutionName nvarchar(150)
,Status nvarchar(1)
,Remarks nvarchar(150)

,PRIMARY KEY (InstitutionId)
)

CREATE TABLE RelTenantInstitution(
 RelTenantInstitutionId int IDENTITY(1,1) 
,TenantId int
,InstitutionId int
,InstitutionTypeId int

,PRIMARY KEY (RelTenantInstitutionId)
,FOREIGN KEY (TenantId) REFERENCES Tenant(TenantId)
,FOREIGN KEY (InstitutionId) REFERENCES Institution(InstitutionId)
,FOREIGN KEY (InstitutionTypeId) REFERENCES InstitutionType(InstitutionTypeId)
)

CREATE TABLE Banner(
 BannerId int IDENTITY(1,1) 
,RelTenantInstitutionId int
,BannerName nvarchar(50)
,BannerStreamId uniqueidentifier

,PRIMARY KEY (BannerId)
,FOREIGN KEY (RelTenantInstitutionId) REFERENCES RelTenantInstitution(RelTenantInstitutionId)
)



CREATE TABLE Branch(
 BranchId int IDENTITY(1,1) 
,RelTenantInstitutionId int
,BranchName nvarchar(60)

,PRIMARY KEY (BranchId)
,FOREIGN KEY (RelTenantInstitutionId) REFERENCES RelTenantInstitution(RelTenantInstitutionId)
)

CREATE TABLE Section(
 SectionId int IDENTITY(1,1) 
,BranchId int
,BranchName nvarchar(60)

,PRIMARY KEY (SectionId)
,FOREIGN KEY (BranchId) REFERENCES Branch(BranchId)
)

CREATE TABLE Person(
 PersonId int IDENTITY(1,1) 
,FirstName nvarchar(50)
,LastName nvarchar(50)
,DateOfBirth datetime
,Gender nvarchar(1)
,PersonTypeId int
,PhotoStreamId uniqueidentifier
,AuditCreatedBy int
,AuditCreatedDate datetime
,AuditModifiedBy int
,AuditModifiedDate datetime

,PRIMARY KEY (PersonId)
,FOREIGN KEY (PersonTypeId) REFERENCES PersonType(PersonTypeId)
)

CREATE TABLE LoginCredential(
 LoginCredential int IDENTITY(1,1)
,PersonId int
,Email nvarchar(60)
,PhoneNumber nvarchar(50)
,Passcode nvarchar(255)
,PasswordHash nvarchar(128)
,PasswordSalt nvarchar(128)

,PRIMARY KEY (LoginCredential)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)         
)

CREATE TABLE SuperAdmin(
 SuperAdminId int IDENTITY(1,1)
,PersonId int

,PRIMARY KEY (SuperAdminId)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)         
)

CREATE TABLE InstitutionAdmin(
 InstitutionAdminId int IDENTITY(1,1)
,PersonId int
,SecondaryPOCName nvarchar(50)
,SecondaryPOCEmail nvarchar(50)
,SecondaryPOCPhoneNumber nvarchar(50)
,RelTenantInstitutionId int         
,PRIMARY KEY (InstitutionAdminId)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)  
,FOREIGN KEY (RelTenantInstitutionId) REFERENCES RelTenantInstitution(RelTenantInstitutionId)         
)

CREATE TABLE BranchAdmin(
 BranchAdminId int IDENTITY(1,1)
,PersonId int
,BranchId int
 
,PRIMARY KEY (BranchAdminId)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)  
,FOREIGN KEY (BranchId) REFERENCES Branch(BranchId)         
)
     
CREATE TABLE Parent(
 ParentId int IDENTITY(1,1)
,PersonId int
,SecondaryPhoneNumber nvarchar(50)
,RelTenantInstitutionId int

,PRIMARY KEY (ParentId)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)
) 

CREATE TABLE Child(
 ChildId int IDENTITY(1,1)
,ParentId int
,ChildrenName nvarchar(50)
,AdmissionId int
,SectionId int

,PRIMARY KEY (ChildId)
,FOREIGN KEY (ParentId) REFERENCES Parent(ParentId)
,FOREIGN KEY (SectionId) REFERENCES Section(SectionId)
) 

CREATE TABLE Instructor(
 InstructorId int IDENTITY(1,1)
,PersonId int
,SectionId int
,PRIMARY KEY (InstructorId)
,FOREIGN KEY (PersonId) REFERENCES Person(PersonId)
,FOREIGN KEY (SectionId) REFERENCES Section(SectionId)
) 
 

CREATE TABLE Post(
 PostId int IDENTITY(1,1)
,PostText  nvarchar(255)
,PostTypeId int
,SectionId int
,AttachmentStreamId uniqueidentifier

,PRIMARY KEY (PostId)
,FOREIGN KEY (PostTypeId) REFERENCES PostType(PostTypeId)
,FOREIGN KEY (SectionId) REFERENCES Section(SectionId)

,AuditCreatedBy int
,AuditCreatedDate datetime
,AuditModifiedBy int
,AuditModifiedDate datetime 
)  

CREATE TABLE Address(
 AddressId int IDENTITY(1,1)
,Address1 nvarchar(150)
,Address2 nvarchar(150)
,CityId int
,StateId int
,CountryId int
,Pincode nvarchar(6)

,PRIMARY KEY (AddressId)
) 

CREATE TABLE Country(
 CountryId int IDENTITY(1,1)
,CountryName nvarchar(75)
,CountryCode nvarchar(10)
,CountryAlphaCode varchar(2)

,PRIMARY KEY (CountryId)
) 

CREATE TABLE State(
 StateId int IDENTITY(1,1)
,StateName nvarchar(75)
,CountryId int
,CountryAlphaCode varchar(2)

,PRIMARY KEY (StateId)
,FOREIGN KEY (CountryId) REFERENCES Country(CountryId)
) 

CREATE TABLE City(
 CityId int IDENTITY(1,1)
,CityName nvarchar(75)
,StateId int

,PRIMARY KEY (CityId)
,FOREIGN KEY (StateId) REFERENCES State(StateId)
) 


CREATE TABLE RelTenantInstitutionAddress(
 RelTenantInstitutionAddress int IDENTITY(1,1)
,RelTenantInstitutionId  int
,AddressId int

,PRIMARY KEY (RelTenantInstitutionAddress)
,FOREIGN KEY (RelTenantInstitutionId) REFERENCES RelTenantInstitution(RelTenantInstitutionId)
,FOREIGN KEY (AddressId) REFERENCES Address(AddressId)
)  
