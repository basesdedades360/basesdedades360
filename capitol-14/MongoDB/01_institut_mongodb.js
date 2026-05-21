// ============================================================
//  CÀRREGA DE LA BASE DE DADES 'institut' a MongoDB
//  Format: script de mongosh (executar amb load("institut.js"))
//
//  Aquest script crea les col·leccions equivalents a les taules
//  del model relacional emprat als capítols anteriors:
//
//      departament, professor, alumne, modul, matricula
//
//  S'ha optat per un disseny d'estil relacional: cada col·lecció
//  manté el seu _id propi i les relacions es resolen mitjançant
//  referències ($lookup). Així es facilita la comparació amb
//  els capítols SQL.
//
//  Punts deliberadament inclosos per fer pràctiques riques:
//    · Professors actius i inactius (camp 'actiu')
//    · Salaris i dates d'alta variats per departament
//    · Un mòdul sense professor assignat (id_prof = null)
//    · Alumnes sense cap matrícula (Quim i Adriana)
//    · Mòduls sense matriculacions
//    · Notes 'null' (avaluació pendent) i múltiples convocatòries
// ============================================================

// Selecciona o crea la base de dades
db = db.getSiblingDB("institut");

// Neteja prèvia per poder reexecutar l'script sense errors
db.matricula.drop();
db.modul.drop();
db.alumne.drop();
db.professor.drop();
db.departament.drop();

// ------------------------------------------------------------
//  DEPARTAMENTS
// ------------------------------------------------------------
db.departament.insertMany([
    { _id: 1, nom_dept: "Informàtica",         edifici: "Edifici A" },
    { _id: 2, nom_dept: "Disseny",             edifici: "Edifici B" },
    { _id: 3, nom_dept: "Anglès",              edifici: "Edifici A" },
    { _id: 4, nom_dept: "Orientació Laboral",  edifici: "Edifici C" },
    { _id: 5, nom_dept: "Sanitat",             edifici: "Edifici D" },
    { _id: 6, nom_dept: "Administració",       edifici: "Edifici C" },
    { _id: 7, nom_dept: "Electrònica",         edifici: "Edifici A" }
]);

// ------------------------------------------------------------
//  PROFESSORS
// ------------------------------------------------------------
db.professor.insertMany([
    { _id:  1, nom: "Héctor", cognoms: "Maeso",   email: "hmaeso@institut.cat",
      telefon: "600111222", salari: 2950.00, data_alta: ISODate("2010-09-01"), actiu: true,  id_dept: 1 },
    { _id:  2, nom: "Marta",  cognoms: "Soler",   email: "msoler@institut.cat",
      telefon: "600222333", salari: 2700.50, data_alta: ISODate("2015-09-01"), actiu: true,  id_dept: 1 },
    { _id:  3, nom: "Jordi",  cognoms: "Vila",    email: "jvila@institut.cat",
      telefon: "600333444", salari: 2450.00, data_alta: ISODate("2018-09-01"), actiu: true,  id_dept: 1 },
    { _id:  4, nom: "Eva",    cognoms: "Romero",  email: "eromero@institut.cat",
      telefon: "600444555", salari: 2600.00, data_alta: ISODate("2012-09-01"), actiu: false, id_dept: 1 },
    { _id:  5, nom: "Dori",   cognoms: "Garcia",  email: "dgarcia@institut.cat",
      telefon: "600555666", salari: 2800.00, data_alta: ISODate("2011-09-01"), actiu: true,  id_dept: 2 },
    { _id:  6, nom: "Anna",   cognoms: "Martí",   email: "amarti@institut.cat",
      telefon: "600666777", salari: 2300.00, data_alta: ISODate("2020-09-01"), actiu: true,  id_dept: 2 },
    { _id:  7, nom: "Ramón",  cognoms: "Redondo", email: "rredondo@institut.cat",
      telefon: "600777888", salari: 2550.00, data_alta: ISODate("2014-09-01"), actiu: true,  id_dept: 3 },
    { _id:  8, nom: "Sergi",  cognoms: "Mas",     email: "smas@institut.cat",
      telefon: "600888999", salari: 2200.00, data_alta: ISODate("2021-09-01"), actiu: true,  id_dept: 3 },
    { _id:  9, nom: "Isabel", cognoms: "Garcia",  email: "igarcia@institut.cat",
      telefon: "600999000", salari: 2750.00, data_alta: ISODate("2013-09-01"), actiu: true,  id_dept: 4 },
    { _id: 10, nom: "Pere",   cognoms: "Roca",    email: "proca@institut.cat",
      telefon: "601111222", salari: 2900.00, data_alta: ISODate("2009-09-01"), actiu: true,  id_dept: 5 },
    { _id: 11, nom: "Laia",   cognoms: "Puig",    email: "lpuig@institut.cat",
      telefon: "601222333", salari: 2400.00, data_alta: ISODate("2019-09-01"), actiu: false, id_dept: 5 },
    { _id: 12, nom: "Núria",  cognoms: "Camps",   email: "ncamps@institut.cat",
      telefon: "601333444", salari: 2650.00, data_alta: ISODate("2016-09-01"), actiu: true,  id_dept: 6 },
    { _id: 13, nom: "Carles", cognoms: "Bosch",   email: "cbosch@institut.cat",
      telefon: "601444555", salari: 2850.00, data_alta: ISODate("2012-09-01"), actiu: true,  id_dept: 7 }
]);

// ------------------------------------------------------------
//  ALUMNES
// ------------------------------------------------------------
db.alumne.insertMany([
    { _id:  1, nom: "Marc",    cognoms: "Puig Vidal",  email: "marcpv@alumnes.cat",
      data_naix: ISODate("2005-03-12"), telefon: "610111111", curs_inici: 2024 },
    { _id:  2, nom: "Laia",    cognoms: "Solé Mas",    email: "laiasm@alumnes.cat",
      data_naix: ISODate("2004-07-22"), telefon: "610222222", curs_inici: 2023 },
    { _id:  3, nom: "Pol",     cognoms: "Riera Bosch", email: "polrb@alumnes.cat",
      data_naix: ISODate("2005-11-05"), telefon: "610333333", curs_inici: 2024 },
    { _id:  4, nom: "Júlia",   cognoms: "Font Casas",  email: "juliafc@alumnes.cat",
      data_naix: ISODate("2003-02-18"), telefon: "610444444", curs_inici: 2023 },
    { _id:  5, nom: "Aleix",   cognoms: "Roca Vila",   email: "aleixrv@alumnes.cat",
      data_naix: ISODate("2005-09-30"), telefon: null,        curs_inici: 2024 },
    { _id:  6, nom: "Berta",   cognoms: "Camps Tort",  email: "bertact@alumnes.cat",
      data_naix: ISODate("2004-05-14"), telefon: "610666666", curs_inici: 2023 },
    { _id:  7, nom: "Nil",     cognoms: "Bosch Soler", email: "nilbs@alumnes.cat",
      data_naix: ISODate("2006-01-08"), telefon: "610777777", curs_inici: 2025 },
    { _id:  8, nom: "Clara",   cognoms: "Vidal Puig",  email: "claravp@alumnes.cat",
      data_naix: ISODate("2005-04-25"), telefon: "610888888", curs_inici: 2024 },
    { _id:  9, nom: "Arnau",   cognoms: "Mas Riera",   email: "arnaumr@alumnes.cat",
      data_naix: ISODate("2004-10-11"), telefon: "610999999", curs_inici: 2023 },
    { _id: 10, nom: "Maria",   cognoms: "Tort Font",   email: "mariatf@alumnes.cat",
      data_naix: ISODate("2005-06-19"), telefon: "611000000", curs_inici: 2024 },
    { _id: 11, nom: "Èlia",    cognoms: "Soler Camps", email: "eliasc@alumnes.cat",
      data_naix: ISODate("2006-03-03"), telefon: "611111111", curs_inici: 2025 },
    { _id: 12, nom: "Roger",   cognoms: "Garcia Roca", email: "rogergr@alumnes.cat",
      data_naix: ISODate("2003-12-27"), telefon: "611222222", curs_inici: 2022 },
    { _id: 13, nom: "Ona",     cognoms: "Casas Bosch", email: "onacb@alumnes.cat",
      data_naix: ISODate("2005-08-15"), telefon: null,        curs_inici: 2024 },
    { _id: 14, nom: "Biel",    cognoms: "Vila Mas",    email: "bielvm@alumnes.cat",
      data_naix: ISODate("2004-02-09"), telefon: "611444444", curs_inici: 2023 },
    { _id: 15, nom: "Jana",    cognoms: "Puig Tort",   email: "janapt@alumnes.cat",
      data_naix: ISODate("2006-05-21"), telefon: "611555555", curs_inici: 2025 },
    { _id: 16, nom: "Aitor",   cognoms: "Riera Camps", email: "aitorrc@alumnes.cat",
      data_naix: ISODate("2003-09-06"), telefon: "611666666", curs_inici: 2022 },
    { _id: 17, nom: "Lluc",    cognoms: "Mas Vidal",   email: "llucmv@alumnes.cat",
      data_naix: ISODate("2005-12-14"), telefon: "611777777", curs_inici: 2024 },
    { _id: 18, nom: "Gal·la",  cognoms: "Bosch Riera", email: "gallabr@alumnes.cat",
      data_naix: ISODate("2004-04-02"), telefon: "611888888", curs_inici: 2023 },
    { _id: 19, nom: "Quim",    cognoms: "Font Soler",  email: "quimfs@alumnes.cat",
      data_naix: ISODate("2005-10-28"), telefon: null,        curs_inici: 2024 },
    { _id: 20, nom: "Adriana", cognoms: "Roca Garcia", email: "adrianarg@alumnes.cat",
      data_naix: ISODate("2006-07-17"), telefon: "612000000", curs_inici: 2025 }
]);

// ------------------------------------------------------------
//  MÒDULS
// ------------------------------------------------------------
db.modul.insertMany([
    // Informàtica
    { _id:  1, codi: "INF101", nom_modul: "Bases de dades",                 hores: 165, curs: 1, id_prof:  1 },
    { _id:  2, codi: "INF102", nom_modul: "Programació",                    hores: 297, curs: 1, id_prof:  2 },
    { _id:  3, codi: "INF103", nom_modul: "Llenguatges de marques",         hores:  99, curs: 1, id_prof:  3 },
    { _id:  4, codi: "INF104", nom_modul: "Entorns de desenvolupament",     hores:  66, curs: 1, id_prof:  4 },
    { _id:  5, codi: "INF105", nom_modul: "Sistemes informàtics",           hores: 165, curs: 1, id_prof:  2 },
    { _id:  6, codi: "INF201", nom_modul: "Accés a dades",                  hores: 132, curs: 2, id_prof:  1 },
    { _id:  7, codi: "INF202", nom_modul: "Desenvolupament d'interfícies",  hores: 132, curs: 2, id_prof:  3 },
    // Disseny
    { _id:  8, codi: "DIS101", nom_modul: "Tipografia",                     hores:  99, curs: 1, id_prof:  5 },
    { _id:  9, codi: "DIS102", nom_modul: "Dibuix artístic",                hores: 132, curs: 1, id_prof:  6 },
    { _id: 10, codi: "DIS201", nom_modul: "Disseny gràfic editorial",       hores: 165, curs: 2, id_prof:  5 },
    // Anglès
    { _id: 11, codi: "ENG101", nom_modul: "Anglès tècnic I",                hores:  99, curs: 1, id_prof:  7 },
    { _id: 12, codi: "ENG201", nom_modul: "Anglès tècnic II",               hores:  99, curs: 2, id_prof:  8 },
    // Orientació Laboral
    { _id: 13, codi: "FOL101", nom_modul: "Formació i orientació laboral",  hores:  99, curs: 1, id_prof:  9 },
    { _id: 14, codi: "FOL201", nom_modul: "Empresa i iniciativa emprenedora", hores: 66, curs: 2, id_prof:  9 },
    // Sanitat
    { _id: 15, codi: "SAN101", nom_modul: "Anatomia patològica",            hores: 132, curs: 1, id_prof: 10 },
    { _id: 16, codi: "SAN201", nom_modul: "Biologia molecular",             hores: 165, curs: 2, id_prof: 10 },
    // Electrònica
    { _id: 17, codi: "ELE101", nom_modul: "Electrònica analògica",          hores: 165, curs: 1, id_prof: 13 },
    { _id: 18, codi: "ELE201", nom_modul: "Electrònica digital",            hores: 132, curs: 2, id_prof: 13 },
    // Administració
    { _id: 19, codi: "ADM101", nom_modul: "Comptabilitat",                  hores: 132, curs: 1, id_prof: 12 },
    { _id: 20, codi: "ADM201", nom_modul: "Gestió logística",               hores:  99, curs: 2, id_prof: null }
]);

// ------------------------------------------------------------
//  MATRÍCULES
// ------------------------------------------------------------
//  No tenen _id explícit: MongoDB en generarà un d'ObjectId.
//  Els camps equivalents a la PK relacional són
//  (id_alumne, id_modul, convocatoria).
db.matricula.insertMany([
    // Marc (1) — Informàtica curs 1
    { id_alumne:  1, id_modul:  1, nota_final: 7.50, convocatoria: 1 },
    { id_alumne:  1, id_modul:  2, nota_final: 6.25, convocatoria: 1 },
    { id_alumne:  1, id_modul:  3, nota_final: 8.00, convocatoria: 1 },
    { id_alumne:  1, id_modul:  4, nota_final: 4.50, convocatoria: 1 },
    { id_alumne:  1, id_modul:  4, nota_final: 5.50, convocatoria: 2 },
    { id_alumne:  1, id_modul:  5, nota_final: 9.00, convocatoria: 1 },
    { id_alumne:  1, id_modul: 11, nota_final: 7.00, convocatoria: 1 },
    { id_alumne:  1, id_modul: 13, nota_final: 6.50, convocatoria: 1 },

    // Laia (2) — Informàtica curs 2
    { id_alumne:  2, id_modul:  6, nota_final: 8.50, convocatoria: 1 },
    { id_alumne:  2, id_modul:  7, nota_final: 7.25, convocatoria: 1 },
    { id_alumne:  2, id_modul: 12, nota_final: 6.00, convocatoria: 1 },
    { id_alumne:  2, id_modul: 14, nota_final: null, convocatoria: 1 },

    // Pol (3) — repetidor a Bases de dades
    { id_alumne:  3, id_modul:  1, nota_final: 4.25, convocatoria: 1 },
    { id_alumne:  3, id_modul:  1, nota_final: 3.00, convocatoria: 2 },
    { id_alumne:  3, id_modul:  1, nota_final: 5.10, convocatoria: 3 },
    { id_alumne:  3, id_modul:  2, nota_final: 5.00, convocatoria: 1 },
    { id_alumne:  3, id_modul:  3, nota_final: 6.50, convocatoria: 1 },

    // Júlia (4) — Disseny
    { id_alumne:  4, id_modul: 10, nota_final: 8.75, convocatoria: 1 },
    { id_alumne:  4, id_modul:  8, nota_final: 7.00, convocatoria: 1 },
    { id_alumne:  4, id_modul: 12, nota_final: 5.50, convocatoria: 1 },

    // Aleix (5)
    { id_alumne:  5, id_modul:  1, nota_final: null, convocatoria: 1 },
    { id_alumne:  5, id_modul:  2, nota_final: 7.80, convocatoria: 1 },
    { id_alumne:  5, id_modul:  3, nota_final: 9.10, convocatoria: 1 },

    // Berta (6) — Disseny
    { id_alumne:  6, id_modul:  8, nota_final: 8.20, convocatoria: 1 },
    { id_alumne:  6, id_modul:  9, nota_final: 6.50, convocatoria: 1 },
    { id_alumne:  6, id_modul: 11, nota_final: 4.00, convocatoria: 1 },
    { id_alumne:  6, id_modul: 11, nota_final: 6.10, convocatoria: 2 },
    { id_alumne:  6, id_modul: 13, nota_final: 7.50, convocatoria: 1 },

    // Nil (7) — tot pendent
    { id_alumne:  7, id_modul:  1, nota_final: null, convocatoria: 1 },
    { id_alumne:  7, id_modul:  2, nota_final: null, convocatoria: 1 },
    { id_alumne:  7, id_modul:  3, nota_final: null, convocatoria: 1 },

    // Clara (8) — Sanitat
    { id_alumne:  8, id_modul: 15, nota_final: 8.00, convocatoria: 1 },
    { id_alumne:  8, id_modul: 16, nota_final: 7.40, convocatoria: 1 },
    { id_alumne:  8, id_modul: 13, nota_final: 6.80, convocatoria: 1 },

    // Arnau (9) — Electrònica
    { id_alumne:  9, id_modul: 17, nota_final: 7.00, convocatoria: 1 },
    { id_alumne:  9, id_modul: 18, nota_final: 8.50, convocatoria: 1 },

    // Maria (10)
    { id_alumne: 10, id_modul: 19, nota_final: 6.20, convocatoria: 1 },
    { id_alumne: 10, id_modul: 11, nota_final: 5.30, convocatoria: 1 },

    // Èlia (11) — molt bona alumna
    { id_alumne: 11, id_modul:  8, nota_final: 9.50, convocatoria: 1 },
    { id_alumne: 11, id_modul:  9, nota_final: 8.80, convocatoria: 1 },
    { id_alumne: 11, id_modul: 11, nota_final: 7.20, convocatoria: 1 },
    { id_alumne: 11, id_modul: 13, nota_final: 8.00, convocatoria: 1 },

    // Roger (12)
    { id_alumne: 12, id_modul:  6, nota_final: 4.00, convocatoria: 1 },
    { id_alumne: 12, id_modul:  6, nota_final: 5.20, convocatoria: 2 },
    { id_alumne: 12, id_modul:  7, nota_final: 6.00, convocatoria: 1 },

    // Ona (13) — només una matrícula
    { id_alumne: 13, id_modul: 15, nota_final: 7.30, convocatoria: 1 },

    // Biel (14) — Anglès suspès i recuperat
    { id_alumne: 14, id_modul: 17, nota_final: 5.80, convocatoria: 1 },
    { id_alumne: 14, id_modul: 11, nota_final: 4.50, convocatoria: 1 },
    { id_alumne: 14, id_modul: 11, nota_final: 5.00, convocatoria: 2 },

    // Jana (15) — just començada
    { id_alumne: 15, id_modul: 19, nota_final: null, convocatoria: 1 },
    { id_alumne: 15, id_modul: 11, nota_final: null, convocatoria: 1 },

    // Aitor (16) — Informàtica curs 2
    { id_alumne: 16, id_modul:  6, nota_final: 8.20, convocatoria: 1 },
    { id_alumne: 16, id_modul:  7, nota_final: 7.50, convocatoria: 1 },

    // Lluc (17)
    { id_alumne: 17, id_modul:  1, nota_final: 5.00, convocatoria: 1 },
    { id_alumne: 17, id_modul:  2, nota_final: 5.10, convocatoria: 1 },
    { id_alumne: 17, id_modul:  3, nota_final: 5.20, convocatoria: 1 },

    // Gal·la (18) — Sanitat
    { id_alumne: 18, id_modul: 16, nota_final: 9.20, convocatoria: 1 },
    { id_alumne: 18, id_modul: 12, nota_final: 8.10, convocatoria: 1 }

    // Quim (19) i Adriana (20): sense matrícules a propòsit.
]);

// ------------------------------------------------------------
//  ÍNDEXS BÀSICS (opcionals però recomanats per a les pràctiques)
// ------------------------------------------------------------
db.professor.createIndex({ email: 1 }, { unique: true });
db.alumne.createIndex({ email: 1 }, { unique: true });
db.modul.createIndex({ codi: 1 }, { unique: true });
db.matricula.createIndex(
    { id_alumne: 1, id_modul: 1, convocatoria: 1 },
    { unique: true }
);

// ------------------------------------------------------------
//  RESUM DE LA CÀRREGA
// ------------------------------------------------------------
print("Càrrega completada:");
print("  departaments: " + db.departament.countDocuments());
print("  professors:   " + db.professor.countDocuments());
print("  alumnes:      " + db.alumne.countDocuments());
print("  mòduls:       " + db.modul.countDocuments());
print("  matrícules:   " + db.matricula.countDocuments());
