-- Script hoort bij de Zorginformatiebouwstenen BurgelijkeStaat. (https://zibs.nl/wiki/BurgerlijkeStaat(NL))
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)
 
select 
   ifct_bsn                     as "identifier"         -- PatientIdentificatienummer. (FHIR - identifier)
   , null                       as "in_gebruik"         -- Is patientenrecord in gebruik. (FHIR - active)
   , ifct_burgelijke_staat      as "burgelijke_staat"   -- zib's BurgelijkeStaat definieert BurgelijkeStaatCodes: https://zibs.nl/wiki/BurgerlijkeStaat(NL)#BurgerlijkeStaatCodelijst

from mtdx.v_intf_contact
where ifct_soort = 9                                    -- Filteren op patienten.