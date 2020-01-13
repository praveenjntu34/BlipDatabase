select * from RelTenantInstitution

select * from Institution

select * from Person

select * from InstitutionAdmin

select B.BranchName, S.SectionName from Branch B
JOIN Section S ON S.BranchId =  B.BranchId

select I.InstitutionName,P.FirstName as 'PrimaryAdmin', IA.SecondaryPOCName AS 'SecondaryAdmin', b.BranchName as 'Branches', S.SectionName AS 'Sections' from RelTenantInstitution ri
JOIN Institution I ON I.InstitutionId = ri.InstitutionId
JOIN InstitutionAdmin IA ON IA.RelTenantInstitutionId = ri.RelTenantInstitutionId
JOIN Person P ON P.PersonId = IA.PersonId
JOIN Branch b on b.RelTenantInstitutionId = ri.RelTenantInstitutionId
LEFT JOIN Section S ON S.BranchId =  b.BranchId


SELECT I.InstitutionName, IDP.PictureStream, C.CityName, S.StateName, CN.CountryName FROM RelTenantInstitution RI
JOIN Institution I ON I.InstitutionId = RI.InstitutionId
JOIN InstitutionDisplayPicture IDP ON I.PictureId = IDP.PictureId
JOIN Address AD ON AD.AddressId = RI.AddressId
JOIN City C ON C.CityId = AD.CityId
JOIN State S ON S.StateId = AD.StateId
JOIN Country CN ON CN.CountryId = AD.CountryId
 

 select RI.RelTenantInstitutionId
,IT.InstitutionTypeName
,I.InstitutionId
,I.InstitutionName
,I.Email
,I.Website
,AD.Address1
,AD.Address2
,ST.StateName
,CT.CityName
,IDP.PictureId
,P.FirstName AS 'PrimaryPOCFirstName'
,P.LastName as 'PrimaryPOCLastName'
,LC.Email AS 'PrimaryPOCEmail'
,LC.PhoneNumber AS 'PrimaryPOCPhoneNumber'
,IA.SecondaryPOCName
,IA.SecondaryPOCEmail
,IA.SecondaryPOCPhoneNumber
FROM RelTenantInstitution RI
JOIN InstitutionType IT ON IT.InstitutionTypeId = RI.InstitutionTypeId
JOIN Institution I ON I.InstitutionId = RI.InstitutionId
JOIN Address AD ON AD.AddressId = RI.AddressId
JOIN [State] ST ON ST.StateId = AD.StateId
JOIN City CT ON CT.CityId = AD.CityId
JOIN InstitutionDisplayPicture IDP ON IDP.PictureId = I.PictureId
JOIN InstitutionAdmin IA ON IA.RelTenantInstitutionId = RI.RelTenantInstitutionId
JOIN Person P ON P.PersonId = IA.PersonId
JOIN LoginCredential LC ON LC.PersonId = P.PersonId
WHERE RI.RelTenantInstitutionId = 2
