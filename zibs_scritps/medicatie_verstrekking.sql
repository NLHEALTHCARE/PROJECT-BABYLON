-- Script hoort bij de Zorginformatiebouwsteen (zib) MedicatieVerstrekking. (https://zibs.nl/wiki/MedicatieVerstrekking(NL))
-- De FHIR resource MedicationStatement is hier deels voor gebruikt. (https://www.hl7.org/fhir/medicationstatement.html#resource)
-- Voor deze zib is ook deels gebruik gemaakt van de zib MedicatieVoorscrift voor de codelijsten van voorschrijven en dosering.

select
        null                            as "product"                                    -- zib definieert de medicatie die is/wordt toegediend.
        , null                          as "medicatie_voorschrift_status"               -- zib MedicatieVoorschrift definieert MedicatieVoorschriftStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.5.1
        , null                          as "medicatie_voorschrift_reden_stoppen"        -- zib MedicatieVoorschrift definieert MedicatieVoorschriftRedenVanStoppenCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.5.2
        , null                          as "medicatie_voorschrift_reden_onderbreken"    -- zib MedicatieVoorschrift definieert MedicatieVoorschriftRedenVanOnderbrekenCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.5.3
        , null                          as "datum_medicatie_voorschrift"                -- zib definieert de datum waarop het voorschrift is opgesteld.
        , null                          as "reden_voorschrijven"                        -- zib definieert de medische reden voor voorschrijven of gebruik van de medicatie.
        , null                          as "zorgverlener"                               -- zib definieert de zorgverlener die verantwoordelijk is voor het voorschrift.
        , null                          as "patient_id"                                 -- zib definieert de patient die zichzelf een middel heeft voorgeschreven.
        , null                          as "contactpersoon"                             -- zib definieert een contactpersoon (mantelverzorger) die het middel heeft vorogeschreven.
        , null                          as "toelichting"                                -- zib definieert een toelichting met betrekking tot de medicatie voorschrift.
        , null                          as "dosering_start_datum"                       -- zib definieert de datum en de tijd waarop het gebruik van de dosering is gestart of zal starten.
        , null                          as "dosering_eind_datum"                        -- zib definieert de datum en de tijd waarop gestopt is met de dosering. Dit kan een afgesproken datum zijn of een staakdatum.
        , null                          as "dosering_gebruiksduur"                      -- zib definieert de gebruiksduur die niet berekend kan worden uit de start en stop datum. Een voorbeeld hiervan is een tijdelijke slaapmedicatie.
        , null                          as "dosering_aantal_toedieningen"               -- zib definieert de beoogde duur van de gebruiksperiode.
        , null                          as "dosering_keer_dosis"                        -- zib definieert de dosis per inname of toediening
        , null                          as "toedieningsweg"                             -- zib MedicatieVerstrekking definieert VoorschriftToedieningswegCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.3.3
        , null                          as "inloopsnelheid"                             -- zib definieert de inloopsnelheid bij langzame toediening van vloeistoffen, de meeteenheid is vrijwel altijd ml/uur. Het opgeven van een interval is ook een optie.
        , null                          as "toedieningsduur"                            -- zib definieert de tijdsduur gedurende welke het medicijn wordt toegediend en wordt gebruikt bij de langzame toediening van vloeistoffen.
        , null                          as "aanvullende_toelichting"                    -- zib definieert een aanvullende toelichting voor het gebruik of de overwegingen voor het huidige voorschrift.
        , null                          as "criterium"                                  -- zib definieert een voorwaarde voor het toedienen van het medicament, deze voorwaarde kan een fysiologische meetwaarde, symptoom of andere omstandigheden zijn.
        , null                          as "maximum_aantal_per_tijd"                    -- zib definieert het maximum gebruik van het middel in een 'zo nodig' voorschrift.
        , null                          as "zo_nodig"                                   -- zib definieert een indicator die aangeeft of de toediening alleen onder bepaalde voorwaarden mag worden uitgevoerd.
        , null                          as "periode_gebruik"                            -- zib definieert de verwachte periode dat het medicijn gebruikt zal worden.
        , null                          as "verstrekte_hoeveelheid"                     -- zib definieert het aantal eenheden van het product die is afgeleverd.
        , null                          as "datum_medicatie_verstrekking"               -- zib definieert de datum en tijd aarop de verstrekking heeft plaatsgevonden.
        , null                          as "zorgverlener"                               -- zib definieert de zorgverlener (apotheker), het kan hier ook gaan om een webwinkel, drogisterij of buitenlandse apotheek.
        , null                          as "toelichting"                                -- zib definieert de toelichting of opmerking over de medicatie verstrekking.
        , null                          as "patient"                                    -- Voor wie is de medicatie bedoelt. (FHIR - subject)
        

from mtdx.v_intf_