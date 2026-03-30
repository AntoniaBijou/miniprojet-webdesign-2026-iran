-- =============================================
-- Table des utilisateurs
-- =============================================
CREATE TABLE utilisateurs (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email           VARCHAR(255) NOT NULL UNIQUE,
    mot_de_passe    VARCHAR(255) NOT NULL,
    date_creation         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =============================================
-- Table des catégories
-- =============================================
CREATE TABLE categories (
    id              SERIAL PRIMARY KEY,
    nom             VARCHAR(150) NOT NULL,
    slug            VARCHAR(150) NOT NULL UNIQUE,
    description     TEXT,
    date_creation         TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =============================================
-- Table des articles
-- =============================================
CREATE TABLE articles (
    id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auteur_id        UUID NOT NULL REFERENCES utilisateurs(id) ON DELETE CASCADE,
    categorie_id     INT REFERENCES categories(id) ON DELETE SET NULL,
    titre            VARCHAR(255) NOT NULL,
    slug             VARCHAR(255) NOT NULL UNIQUE,
    contenu          TEXT NOT NULL,
    image_couverture VARCHAR(500),
    publie_le        TIMESTAMP,
    date_creation          TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =============================================
-- Table des statuts d'article (historique)
-- =============================================
CREATE TABLE statut_article (
    id           SERIAL PRIMARY KEY,
    article_id   UUID NOT NULL REFERENCES articles(id) ON DELETE CASCADE,
    statut       VARCHAR(50) NOT NULL,
    date_creation      TIMESTAMP NOT NULL DEFAULT NOW()
);

-- =============================================
-- Table des types de médias
-- =============================================
CREATE TABLE type_media (
    id   SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL UNIQUE
);

-- =============================================
-- Table des médias
-- =============================================
CREATE TABLE medias (
    id              SERIAL PRIMARY KEY,
    article_id      UUID REFERENCES articles(id) ON DELETE CASCADE,
    type_media_id   INT REFERENCES type_media(id) ON DELETE SET NULL,
    chemin_fichier  VARCHAR(500) NOT NULL,
    legende         VARCHAR(255),
    date_creation         TIMESTAMP NOT NULL DEFAULT NOW()
);


-- Index utiles
CREATE INDEX idx_articles_auteur_id ON articles(auteur_id);
CREATE INDEX idx_articles_categorie_id ON articles(categorie_id);
CREATE INDEX idx_articles_publie_le ON articles(publie_le);
CREATE INDEX idx_medias_article_id ON medias(article_id);
CREATE INDEX idx_statut_article_article_id ON statut_article(article_id);
