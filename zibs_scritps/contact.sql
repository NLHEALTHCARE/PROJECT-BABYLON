-- Script hoort bij de Zorginformatiebouwsteen Contact. (https://zibs.nl/wiki/Contact(NL))
-- De FHIR resources Encounter zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/encounter.html#resource)

select
        null                                            as "contact_type"               -- zib's Contact definieert ContactTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.15.1.1
        , ar.ifev_eig_naam                              as "zorgverlener"               -- zib's defineert de zorgverlener waarmee contact heeft plaats gevonden.
        , ar.ifev_vst_naam                              as "zorgaanbieder"              -- zib's definieert de locatie waar het contact heeft plaats gevonden.
        , ar.ifev_datum || ' ' || ar.ifev_starttijd     as "begin_datum_tijd"           -- zib's definieert begin van de datum en de tijd van het contact dat heeft plaast gevonden.
        , ar.ifev_datum || ' ' || ar.ifev_eindtijd      as "einddatum_tijd"             -- zib's definieert eind van de datum en de tijd van het contact.
        , ar.ifev_beh_tekst                             as "probleem_reden"             -- zib's definieert de reden van het contact
        , null                                          as "verrichting"                -- zib's definieert een verrichting die tijdens het contact heeft plaats gevonden.
        , null                                          as "afwijkende_uitslag"         -- zib's definieert een afwijkende uitslag voor de reden van het contact.
        , ar.ifev_id                                    as "identifier"                 -- Identifier van het van het contact. (FHIR - identifier)
        , ct.ifct_bsn                                   as "patient_identifier"         -- Om welke patient gaat het die contact heeft gehad. (FHIR - subject)
        , null                                          as "verwijzing_reden"           -- De verwijzing die heeft geleid tot dit contact. (FHIR - incomingReferral)

from mtdx.v_intf_activiteit_relatie ar
join mtdx.v_intf_contact ct on ar.ifev_rel_nr = ct.ifct_relatienr