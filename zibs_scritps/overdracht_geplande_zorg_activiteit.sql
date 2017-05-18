-- Script hoort bij de Zorginformatiebouwsteen (zib) OverdrachtGeplandeZorgActiviteit. (https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL))
-- De FHIR resources ProcedureRequest en ReferralRequest zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/procedurerequest.html#resource) (https://www.hl7.org/fhir/referralrequest.html#resource)

select
        null                                    as "order_status"               -- zib OverdrachtGeplandeZorgAvtiviteit definieert OrderStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.16.1.2
        , to_char(ifev_datum,'DD-MM-YYYY')      as "begin_datum"                -- zib definieert een geplande of gewenste datum van uitvoering. Een vage datum zoals alleen maand en jaar is toegestaan. Bij Clinical Remidners kan hiermee aangegeven worden vanaf wanneer de handeling uitgevoerd mag worden.
        , to_char(ifev_datum,'DD-MM-YYYY')      as "eind_datum"                 -- zib definieert de eventuele geplande einddatum van de handeling. Afhankelijk van het soort type handeling kan deze datum gezien worden voor wanneer de handeling moet zijn worden uitgevoerd.
        , null                                  as "order_type"                 -- zib OverdrachtGeplandeZorgActiviteit definieert OrderTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.16.1.1
        , null                                  as "order_overige"              -- zib definieert de orders die niet in een van de andere velden passen kunnen als vrije tekst worden beschreven.

from mtdx.v_intf_activiteit_relatie
where ifev_datum >= current_date