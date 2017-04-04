-- Script hoort bij de Zorginformatiebouwsteen BehandelAanwijzing. (https://zibs.nl/wiki/BehandelAanwijzing(NL))
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifev_id                                 as "identifier"                         -- id van de BehandelAanwijzing (FHIR - identifier)
        , null                                  as "patient_identificatienummer"        -- Om welke patient gaat het. (FHIR - subject)
        , null                                  as "geverifieerd"                       -- zib's BehandelAanwijzing definieert bij Verificatie of de behandelaanwijzing is geverifieerd.
        , null                                  as "geverifieerd_bij"                   -- zib's BehandelAanwijzing definieert GeverifieerdBijCodes: https://zibs.nl/wiki/BehandelAanwijzing(NL)#GeverifieerdBijCodelijst
        , null                                  as "verificatie_datum"                  -- zib's BehandelAanwijzing definieert bij Verificatie op welke datum de verificatie heeft plaats gevonden.
        , v_intf_activiteit.ifev_lbl_code_code  as "behandeling"                        -- zib's BehandelAanwijzing definieert BehandelingCodes: https://zibs.nl/wiki/BehandelAanwijzing(NL)#BehandelingCodelijst
        , null                                  as "behandeling_toegestaan"             -- zib's BehandelAanwijzing definieert BehandelingToegestaanCodes: https://zibs.nl/wiki/BehandelAanwijzing(NL)#BehandelingToegestaanCodelijst
        , null                                  as "beperkingen_behandeling"            -- zib's BehandelAanwijzing definieert beperkingen bij een behandeling.
        , null                                  as "datum_begin"                        -- zib's BehandelAanwijzing definieert een begin datum van de BehandelAanwijzing.
        , null                                  as "datum_eind"                         -- zib's BehandelAanwijzing definieert een eind datum van de BehandelAanwijzing.
        , null                                  as "toelichting"                        -- zib's BehandelAanwijzing definieert een toelichting bij de BehandelAanwijzing.
        , null                                  as "wilsverklaring"                     -- zib's BehandelAanwijzing definieert een wilsverklaring van de patient.

from mtdx.v_intf_activiteit