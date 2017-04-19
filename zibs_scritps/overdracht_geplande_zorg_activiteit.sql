-- Script hoort bij de Zorginformatiebouwsteen (zib) OverdrachtGeplandeZorgActiviteit. (https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL))
-- De FHIR resources ProcedureRequest en ReferralRequest zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/procedurerequest.html#resource) (https://www.hl7.org/fhir/referralrequest.html#resource)

select
        'https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL)#OrderStatusCodelijst'                    as "order_status"               -- zib OverdrachtGeplandeZorgAvtiviteit definieert OrderStatusCodes: https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL)#OrderStatusCodelijst
        , to_char(ifev_datum,'DD-MM-YYYY')      as "begin_datum"                -- zib definieert een geplande of gewenste datum van uitvoering. Een vage datum zoals alleen maand en jaar is toegestaan. Bij Clinical Remidners kan hiermee aangegeven worden vanaf wanneer de handeling uitgevoerd mag worden.
        , to_char(ifev_datum,'DD-MM-YYYY')      as "eind_datum"                 -- zib definieert de eventuele geplande einddatum van de handeling. Afhankelijk van het soort type handeling kan deze datum gezien worden voor wanneer de handeling moet zijn worden uitgevoerd.
        , 'https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL)#OrderTypeCodelijst'                  as "order_type"                 -- zib OverdrachtGeplandeZorgActiviteit definieert OrderTypeCodes: https://zibs.nl/wiki/OverdrachtGeplandeZorgActiviteit(NL)#OrderTypeCodelijst
        , null                                  as "order_overige"              -- zib definieert de orders die niet in een van de andere velden passen kunnen als vrije tekst worden beschreven.

from mtdx.v_intf_activiteit_relatie
where ifev_datum >= current_date