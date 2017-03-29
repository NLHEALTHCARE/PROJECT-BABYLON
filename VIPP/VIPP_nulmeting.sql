--De volgende vragen hebben betrekking op het aantal unieke patiënten met een DBC relevant contactmoment.
-------------------
with vraag_16 as (
--16: Hoeveel patiënten hebben de afgelopen 90 dagen zorgcontact gehad met/in uw zorginstelling ? 
        select count(distinct pat.pat_id) as aant_unieke_ptn_met_zorgcontact_90
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 90
            and(
                zga.zga_dbc_zorgactiviteit_code in('190060', '190013', '190012', '190011')
                or reg.zorgactiviteit_code is not null)
        ),
-- 17: Hoeveel poliklinische patiënten (incl. SEH/EHH) hebben de afgelopen 30 dagen zorgcontact gehad met/in uw zorginstelling?
-- Draaien we om: (alle contacten - de OK's van ORT); in JCI is gesteld dat OZ en DE per definitie alleen ambulante zorg leveren
vraag_17_sub_a as (
----- alle contacten afgelopen 30 dgn
        select distinct pat.pat_id 
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 30
            and(
                zga.zga_dbc_zorgactiviteit_code in('190060', '190013', '190012', '190011')
                or reg.zorgactiviteit_code is not null)
        ),

vraag_17_sub_b as (
-- alle OK's van ORT afgelopen 30 dagen
        select distinct pat.pat_id 
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        
        where dag.dag_datum >= current_date - 30
          --  and zga.zga_dbc_zorgactiviteit_code not in('190060', '190013', '190012', '190011')
            and reg.zorgactiviteit_code is not null
            and kli.kli_platform_code = 'Bewegen'
        ),
 
vraag_17_sub as (
-- alle contacten - OK's ORT
        select a.pat_id as contact_tot
                , b.pat_id as contact_niet_poli
        from vraag_17_sub_a a
        
        left join vraag_17_sub_b b on b.pat_id = a.pat_id
        
        ),

vraag_17 as (
-- aantal unieke patienten uit (alle contacten - OK's ORT)
        select count(distinct vraag_17_sub.contact_tot) as aantal_unieke_ptn_met_poli_30
        from vraag_17_sub
        where vraag_17_sub.contact_niet_poli is null 
        ),

vraag_18_sub_a as (
----- alle contacten afgelopen 30 dgn uit LSP-regio
        select distinct pat.pat_id 
                
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left outer join referentie_addendum.ref_registratie_addendum reg on reg.zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                                                                                and dag.dag_datum between reg.startdatum and reg.einddatum
        left outer join dim_pc4 pc4 on pc4.pc4_pc4_code = left(pat.pat_woonadres_postcode,4)
        
        where dag.dag_datum >= current_date - 30
            and(
                zga.zga_dbc_zorgactiviteit_code in('190060', '190013', '190012', '190011')
                or reg.zorgactiviteit_code is not null)
            and (pc4.pc4_corop_plusgebied_naam in ('West-Noord-Brabant ',
                                                        'Arnhem/Nijmegen',
                                                        'Rijnmond',
                                                        'Overig Groot-Rijnmond',
                                                        'Delft en Westland',
                                                        'Zuid-Oost Utrecht',
                                                        'Veluwe',
                                                        'Alkmaar en omgeving',
                                                        'IJmond',
                                                        'Zaanstreek',
                                                        'Edam- volendam en omgeving',
                                                        'Amsterdam',
                                                        'Haarlemmermeer en omgeving',
                                                        'Agglomeratie Haarlem',
                                                        'Flevoland-Midden',
                                                        'Noordoostpolder en Urk',
                                                        'Noord-Overijssel',
                                                        'Utrecht-West',
                                                        'Stadgewest Utrecht',
                                                        'Zuidwest- Drenthe',
                                                        'Noord-Drenthe',
                                                        'Zuidoost-Drenthe',
                                                        'Haarlemmermeer en omgeving',
                                                        'Kop van Noord-Holland')
                  or pc4.pc4_cbs_gemeente_naam in ('Gemeente Oostzaan ',
                                                        'Gemeente Landsmeer',
                                                        'Gemeente Montferland',
                                                        'Gemeente Oude ijsselstreek',
                                                        'Gemeente Doetinchem',
                                                        'Gemeente Bronckhorst',
                                                        'Gemeente Noordwijk',
                                                        'Gemeente Katwijk',
                                                        'Gemeente Noordwijkerhout'))


        ),
        
vraag_18_sub as (
-- alle contacten uit LSP-regio - OK's ORT
        select a.pat_id as contact_tot
                , b.pat_id as contact_niet_poli
        from vraag_18_sub_a a
        
        left join vraag_17_sub_b b on b.pat_id = a.pat_id
        
        ),

vraag_18 as (
-- aantal unieke patienten uit (alle contacten uit LSP-regio - OK's ORT)
        select count(distinct vraag_18_sub.contact_tot) as aantal_unieke_ptn_met_poli_30_LSP
        from vraag_18_sub
        where vraag_18_sub.contact_niet_poli is null 
        ),

vraag_19 as (
--Hoeveel klinische patiënten (incl. dagopnames) zijn de afgelopen 30 dagen opgenomen geweest in uw zorginstelling?        
        select count(distinct pat.pat_id) as aant_unieke_ptn_opgenomen_30
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left join referentie.ref_dbc_zorgactiviteit zkl on zkl.ref_zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                and dag.dag_datum between zkl.ref_begin_datum and coalesce(zkl.ref_eind_datum,'9999-12-31')
        
        where dag.dag_datum >= current_date - 30
        and zkl.ref_klasse_code in ('2','3')
                
        ),
        
vraag_20 as (
--Hoeveel klinische patiënten (incl. dagopnames) uit LSP-regio zijn de afgelopen 30 dagen opgenomen geweest in uw zorginstelling?        
        select count(distinct pat.pat_id) as aant_unieke_ptn_opgenomen_30_lsp
        
        from fct_zorgprofiel zan
        
        inner join dim_dag dag                                           on dag.dag_id = zan.dag_id
        inner join dim_kliniek kli                                       on kli.kli_id = zan.kli_id
        inner join dwh.dim_dbc_zorgactiviteit zga                        on zga.zga_id = zan.zga_id
        inner join dim_patient pat                                       on pat.pat_id = zan.pat_id
        left join referentie.ref_dbc_zorgactiviteit zkl on zkl.ref_zorgactiviteit_code = zga.zga_dbc_zorgactiviteit_code
                and dag.dag_datum between zkl.ref_begin_datum and coalesce(zkl.ref_eind_datum,'9999-12-31')
        left outer join dim_pc4 pc4 on pc4.pc4_pc4_code = left(pat.pat_woonadres_postcode,4)
        
        where dag.dag_datum >= current_date - 30
        and zkl.ref_klasse_code in ('2','3')
        and (pc4.pc4_corop_plusgebied_naam in ('West-Noord-Brabant ',
                                                        'Arnhem/Nijmegen',
                                                        'Rijnmond',
                                                        'Overig Groot-Rijnmond',
                                                        'Delft en Westland',
                                                        'Zuid-Oost Utrecht',
                                                        'Veluwe',
                                                        'Alkmaar en omgeving',
                                                        'IJmond',
                                                        'Zaanstreek',
                                                        'Edam- volendam en omgeving',
                                                        'Amsterdam',
                                                        'Haarlemmermeer en omgeving',
                                                        'Agglomeratie Haarlem',
                                                        'Flevoland-Midden',
                                                        'Noordoostpolder en Urk',
                                                        'Noord-Overijssel',
                                                        'Utrecht-West',
                                                        'Stadgewest Utrecht',
                                                        'Zuidwest- Drenthe',
                                                        'Noord-Drenthe',
                                                        'Zuidoost-Drenthe',
                                                        'Haarlemmermeer en omgeving',
                                                        'Kop van Noord-Holland')
                  or pc4.pc4_cbs_gemeente_naam in ('Gemeente Oostzaan ',
                                                        'Gemeente Landsmeer',
                                                        'Gemeente Montferland',
                                                        'Gemeente Oude ijsselstreek',
                                                        'Gemeente Doetinchem',
                                                        'Gemeente Bronckhorst',
                                                        'Gemeente Noordwijk',
                                                        'Gemeente Katwijk',
                                                        'Gemeente Noordwijkerhout'))
                
        )


select * 
from vraag_16
cross join vraag_17
cross join vraag_18
cross join vraag_19
cross join vraag_20
