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