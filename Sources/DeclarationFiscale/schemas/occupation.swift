import Foundation

var occupationSchema = DeclarationSchema(
    headers:  [
        "declarer","annuler_occupation","noFiscalDuLocal","idGroupLoc","cdDept",
        "libelle_departement","libelle_commune","noVoirie","indRep","libelle_voie",
        "noBatiment","noEscalier","noEtage","noPorte","cdPrefix","cdSection","noPlan",
        "cdNature","cdDescHab","categorie","nbPiecesPpales","surface","surfacePrincipale",
        "surfaceSecCouv","surfaceSecNonCouv","surfaceParkCouv","surfaceParkNonCouv",
        "loyerMensu","actPro","meuble","dteEffetLoyer","typeLoyer","situationOccup",
        "typePersonne_1","spi_1","nomNaissOcc_1","nomUsOcc_1","prenomOcc_1","dteNaiss_1",
        "paysNaiss_1","commNaiss_1","deptNaiss_1","siren_1","denomSoc_1","formJuridiq_1",
        "dteDebOccup_1","dteFinOccup_1","typePersonne_2","spi_2","nomNaissOcc_2",
        "nomUsOcc_2","prenomOcc_2","dteNaiss_2","paysNaiss_2","commNaiss_2","deptNaiss_2",
        "siren_2","denomSoc_2","formJuridiq_2","dteDebOccup_2","dteFinOccup_2",
        "denomGestionnaire","sirenPersonnePhysique","sirenGestionnaire","observation",
        "codeExclusionTlvThlv","dteDerniereDecla","identifiantProvisoire","spi_delegataire",
        "siren_delegataire"
    ],

    groups:  [
        ("Type de déclaration", ["declarer","annuler_occupation"]),
        ("Local", [
            "noFiscalDuLocal","idGroupLoc","cdDept",
            "libelle_departement","libelle_commune","noVoirie","indRep","libelle_voie",
            "noBatiment","noEscalier","noEtage","noPorte","cdPrefix","cdSection","noPlan",
            "cdNature","cdDescHab","categorie","nbPiecesPpales"
        ]),
        ("Surface", [
            "surface","surfacePrincipale","surfaceSecCouv","surfaceSecNonCouv",
            "surfaceParkCouv","surfaceParkNonCouv"
        ]),
        ("Loyer", [
            "loyerMensu","actPro","meuble",
            "dteEffetLoyer","typeLoyer","situationOccup"
        ]),
        ("Occupant 1", [
            "typePersonne_1","spi_1","nomNaissOcc_1","nomUsOcc_1","prenomOcc_1",
            "dteNaiss_1","paysNaiss_1","commNaiss_1","deptNaiss_1","siren_1",
            "denomSoc_1","formJuridiq_1","dteDebOccup_1","dteFinOccup_1"
        ]),
        ("Occupant 2", [
            "typePersonne_2","spi_2","nomNaissOcc_2","nomUsOcc_2","prenomOcc_2",
            "dteNaiss_2","paysNaiss_2","commNaiss_2","deptNaiss_2","siren_2",
            "denomSoc_2","formJuridiq_2","dteDebOccup_2","dteFinOccup_2"
        ]),
        ("Gestion et déclaration", [
            "denomGestionnaire","sirenPersonnePhysique","sirenGestionnaire","observation",
            "codeExclusionTlvThlv","dteDerniereDecla","identifiantProvisoire",
            "spi_delegataire","siren_delegataire"
        ])
    ],

     labels: [
            "declarer":"Déclarer", "annuler_occupation":"Annuler l'occupation",
            "noFiscalDuLocal":"N° fiscal du local", "idGroupLoc":"Identifiant groupe local",
            "cdDept":"Code département", "libelle_departement":"Département",
            "libelle_commune":"Commune", "noVoirie":"N° voirie", "indRep":"Indice de répétition",
            "libelle_voie":"Voie", "noBatiment":"Bâtiment", "noEscalier":"Escalier",
            "noEtage":"Étage", "noPorte":"Porte", "cdPrefix":"Préfixe cadastral",
            "cdSection":"Section cadastrale", "noPlan":"N° plan", "cdNature":"Code nature",
            "cdDescHab":"Description habitation", "categorie":"Catégorie",
            "nbPiecesPpales":"Nombre de pièces principales", "surface":"Surface",
            "surfacePrincipale":"Surface principale", "surfaceSecCouv":"Surface secondaire couverte",
            "surfaceSecNonCouv":"Surface secondaire non couverte", "surfaceParkCouv":"Parking couvert",
            "surfaceParkNonCouv":"Parking non couvert", "loyerMensu":"Loyer mensuel",
            "actPro":"Activité professionnelle", "meuble":"Meublé", "dteEffetLoyer":"Date effet loyer",
            "typeLoyer":"Type de loyer", "situationOccup":"Situation d'occupation",
            "typePersonne_1":"Type de personne", "spi_1":"SPI", "nomNaissOcc_1":"Nom de naissance",
            "nomUsOcc_1":"Nom d'usage", "prenomOcc_1":"Prénom", "dteNaiss_1":"Date de naissance",
            "paysNaiss_1":"Pays de naissance", "commNaiss_1":"Commune de naissance",
            "deptNaiss_1":"Département de naissance", "siren_1":"SIREN",
            "denomSoc_1":"Dénomination société", "formJuridiq_1":"Forme juridique",
            "dteDebOccup_1":"Début d'occupation", "dteFinOccup_1":"Fin d'occupation",
            "typePersonne_2":"Type de personne", "spi_2":"SPI", "nomNaissOcc_2":"Nom de naissance",
            "nomUsOcc_2":"Nom d'usage", "prenomOcc_2":"Prénom", "dteNaiss_2":"Date de naissance",
            "paysNaiss_2":"Pays de naissance", "commNaiss_2":"Commune de naissance",
            "deptNaiss_2":"Département de naissance", "siren_2":"SIREN",
            "denomSoc_2":"Dénomination société", "formJuridiq_2":"Forme juridique",
            "dteDebOccup_2":"Début d'occupation", "dteFinOccup_2":"Fin d'occupation",
            "denomGestionnaire":"Dénomination gestionnaire",
            "sirenPersonnePhysique":"SIREN personne physique", "sirenGestionnaire":"SIREN gestionnaire",
            "observation":"Observation", "codeExclusionTlvThlv":"Code exclusion TLV/THLV",
            "dteDerniereDecla":"Date dernière déclaration",
            "identifiantProvisoire":"Identifiant provisoire", "spi_delegataire":"SPI délégataire",
            "siren_delegataire":"SIREN délégataire"
        ]
    )

