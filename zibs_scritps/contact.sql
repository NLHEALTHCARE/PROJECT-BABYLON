-- Script hoort bij de Zorginformatiebouwsteen Contact. (https://zibs.nl/wiki/Contact(NL))
-- De FHIR resources Encounter zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/encounter.html#resource)

select
        null                                    as "contact_type"               -- zib's Contact definieert ContactTypeCodes: https://zibs.nl/wiki/Contact(NL)#ContactTypeCodelijst
        , ifst_ba_naam                          as "zorgverlener"               -- zib's defineert de zorgverlener waarmee contact heeft plaats gevonden.
        , ifst_vest_naam                        as "zorgaanbieder"              -- zib's definieert de locatie waar het contact heeft plaats gevonden.
        , ifst_startdatum                       as "begin_datum_tijd"           -- zib's definieert begin van de datum en de tijd van het contact dat heeft plaast gevonden.
        , ifst_einddatum                        as "einddatum_tijd"             -- zib's definieert eind van de datum en de tijd van het contact.
        , null /*ifstdiag__omschrijving*/       as "probleem_reden"             -- zib's definieert de reden van het contact
        , null                                  as "verrichting"                -- zib's definieert een verrichting die tijdens het contact heeft plasst gevonden.
        , null                                  as "afwijkende_uitslag"         -- zib's definieert een afwijkende uitslag voord e reden van het contact.
        , ifst_id                               as "identifier"                 -- Identifier van het van het contact. (FHIR - identifier)
        , ifst_pat_bsn                          as "patient_identifier"         -- Om welke patient gaat het die contact heeft gehad. (FHIR - subject)
        , ifst_verwijs_omschrijving             as "verwijzing_reden"           -- De verwijzing die heeft geleid tot dit contact. (FHIR - incomingReferral)

from mtdx.v_intf_subtraject