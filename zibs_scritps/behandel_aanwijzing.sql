-- Script hoort bij de Zorginformatiebouwsteen BehandelAanwijzing. (https://zibs.nl/wiki/BehandelAanwijzing(NL))
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        null                            as "identifier"                         -- id van de BehandelAanwijzing (FHIR - identifier)
        , ct.ifct_bsn                   as "patient_identificatienummer"        -- Om welke patient gaat het. (FHIR - subject)
        , null                          as "geverifieerd"                       -- zib's BehandelAanwijzing definieert bij Verificatie of de behandelaanwijzing is geverifieerd.
        , null                          as "geverifieerd_bij"                   -- zib's BehandelAanwijzing definieert GeverifieerdBijCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.2.4
        , null                          as "verificatie_datum"                  -- zib's BehandelAanwijzing definieert bij Verificatie op welke datum de verificatie heeft plaats gevonden.
        , null                          as "behandeling"                        -- zib's BehandelAanwijzing definieert BehandelingCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.2.1
        , null                          as "behandeling_toegestaan"             -- zib's BehandelAanwijzing definieert BehandelingToegestaanCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.2.2
        , null                          as "beperkingen_behandeling"            -- zib's BehandelAanwijzing definieert beperkingen bij een behandeling.
        , null                          as "datum_begin"                        -- zib's BehandelAanwijzing definieert een begin datum van de BehandelAanwijzing.
        , null                          as "datum_eind"                         -- zib's BehandelAanwijzing definieert een eind datum van de BehandelAanwijzing.
        , null                          as "toelichting"                        -- zib's BehandelAanwijzing definieert een toelichting bij de BehandelAanwijzing.
        , null                          as "wilsverklaring"                     -- zib's BehandelAanwijzing definieert een wilsverklaring van de patient.

from mtdx.v_intf_contact ct
--join ... on ct.ifct_id = 

where ct.ifct_soort = 9 