-- Script hoort bij de Zorginformatiebouwsteen (zib) MedicatieVoorschrift. (https://zibs.nl/wiki/MedicatieVoorschrift(NL))
-- De FHIR resource MedicationRequest is hier deels voor gebruikt. (https://www.hl7.org/fhir/medicationrequest.html#resource)

select
        null                    as "verstrekken_hoeveelheid"                    -- zib definieert het aantal af te leveren eenheden van het bestelde product.
        , null                  as "aantal_deel_verstrekkingen"                 -- zib definieert het aantal herhalingen dat via het voorschrift gedaan mag worden.
        , null                  as "zorgverlener"                               -- zib definieert de beoogde verstrekker, in de meeste gevallen is dit een geregistreerde apotheker.
        , null                  as "dosering_start_datum"                       -- zib definieert de datum en de tijd waarop het gebruik van de dosering is gestart of zal starten.
        , null                  as "dosering_eind_datum"                        -- zib definieert de datum en de tijd waarop gestopt is met de dosering. Dit kan een afgesproken datum zijn of een staakdatum.
        , null                  as "dosering_gebruiksduur"                      -- zib definieert de gebruiksduur die niet berekend kan worden uit de start en stop datum. Een voorbeeld hiervan is een tijdelijke slaapmedicatie.
        , null                  as "dosering_aantal_toedieningen"               -- zib definieert de beoogde duur van de gebruiksperiode.
        , null                  as "dosering_keer_dosis"                        -- zib definieert de dosis per inname of toediening
        , null                  as "toedieningsweg"                             -- zib MedicatieVerstrekking definieert VoorschriftToedieningswegCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#VoorschriftToedieningswegCodelijst
        , null                  as "inloopsnelheid"                             -- zib definieert de inloopsnelheid bij langzame toediening van vloeistoffen, de meeteenheid is vrijwel altijd ml/uur. Het opgeven van een interval is ook een optie.
        , null                  as "toedieningsduur"                            -- zib definieert de tijdsduur gedurende welke het medicijn wordt toegediend en wordt gebruikt bij de langzame toediening van vloeistoffen.
        , null                  as "aanvullende_toelichting"                    -- zib definieert een aanvullende toelichting voor het gebruik of de overwegingen voor het huidige voorschrift.
        , null                  as "criterium"                                  -- zib definieert een voorwaarde voor het toedienen van het medicament, deze voorwaarde kan een fysiologische meetwaarde, symptoom of andere omstandigheden zijn.
        , null                  as "maximum_aantal_per_tijd"                    -- zib definieert het maximum gebruik van het middel in een 'zo nodig' voorschrift.
        , null                  as "zo_nodig"                                   -- zib definieert een indicator die aangeeft of de toediening alleen onder bepaalde voorwaarden mag worden uitgevoerd.
        , null                  as "frequentie"                                 -- zib definieert het aantal doseermomenten per tijdseenheid per dag, wanneer frequentie is opgegeven dan zal Interval niet zijn opgegeven.
        , null                  as "interval"                                   -- zib definieert de tijd tussen de doseermomenten, wanneer Interval is opgegeven dan zal Frequentie niet zijn opgegeven.
        , null                  as "toedientijd"                                -- zib definieert een specifieke (klok)tijd op de dag, deze tijd is meestal niet exact. Er kunnen meerdere inname tijdstippen op een dag zijn.
        , null                  as "weekdagen"                                  -- zib MedicatieVoorschrift definieert WeekdagenCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#WeekdagenCodelijst
        , null                  as "dagdeel"                                    -- zib MedicatieVoorschrift definieert DagdeelCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#DagdeelCodelijst
        , null                  as "medicatie_voorschrift_status"               -- zib MedicatieVoorschrift definieert MedicatieVoorschriftStatusCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#MedicatieVoorschriftStatusCodelijst
        , null                  as "medicatie_voorschrift_reden_stoppen"        -- zib MedicatieVoorschrift definieert MedicatieVoorschriftRedenVanStoppenCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#MedicatieVoorschriftRedenVanStoppenCodelijst
        , null                  as "medicatie_voorschrift_reden_onderbreken"    -- zib MedicatieVoorschrift definieert MedicatieVoorschriftRedenVanOnderbrekenCodes: https://zibs.nl/wiki/MedicatieVoorschrift(NL)#MedicatieVoorschriftRedenVanOnderbrekenCodelijst
        , null                  as "datum_medicatie_voorschrift"                -- zib definieert de datum waarop het voorschrift is opgesteld.
        , null                  as "reden_voorschrijven"                        -- zib definieert de medische reden voor voorschrijven of gebruik van de medicatie.
        , null                  as "zorgverlener"                               -- zib definieert de zorgverlener die verantwoordelijk is voor het voorschrift.
        , null                  as "patient_id"                                 -- zib definieert de patient die zichzelf een middel heeft voorgeschreven.
        , null                  as "contactpersoon"                             -- zib definieert een contactpersoon (mantelverzorger) die het middel heeft vorogeschreven.
        , null                  as "toelichting"                                -- zib definieert een toelichting met betrekking tot de medicatie voorschrift.

from mtdx.v_intf_