-- Script hoort bij de Zorginformatiebouwstenen BurgelijkeStaat. (https://zibs.nl/wiki/BurgerlijkeStaat(NL))
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)
 
select
        ifct_bsn                     as "identifier"         -- PatientIdentificatienummer. (FHIR - identifier). OID: http://art-decor.org/decor/services/RetrieveOID?id=2.16.840.1.113883.2.4.6.3&language=nl-NL
        , null                       as "in_gebruik"         -- Is patientenrecord in gebruik. (FHIR - active)
        , null                       as "burgelijke_staat"   -- zib's BurgelijkeStaat definieert BurgelijkeStaatCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.9.1

from mtdx.v_intf_contact
where ifct_soort = 9                                         -- Filteren op patienten.