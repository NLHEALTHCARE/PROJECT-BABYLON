-- Script hoort bij de Zorginformatiebouwstenen BurgelijkeStaat.
 
select 
   ifct_bsn                     as "identifier"         -- PatientIdentificatienummer. (FHIR)
   , null                       as "in_gebruik"         -- Is patientenrecord in gebruik. (FHIR)
   , ifct_burgelijke_staat      as "burgelijke_staat"   -- zib's BurgelijkeStaat definieert BurgelijkeStaatCodes: https://zibs.nl/wiki/BurgerlijkeStaat(NL)#BurgerlijkeStaatCodelijst

from mtdx.v_intf_contact
where ifct_soort = 9