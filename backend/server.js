// backend/server.js precisei de ajuda com IA para desenvolver essa API de Web Scraping
const express = require('express');
const axios = require('axios');
const cheerio = require('cheerio');
const cors = require('cors');

const app = express();
const PORT = 3000;
app.use(cors());

// URL base do DuckDuckGo para pesquisa no formato HTML
// O formato HTML (html/?) é geralmente mais estável para scraping
const DUCKDUCKGO_BASE_URL = 'https://duckduckgo.com/html/';

app.get('/api/search', async (req, res) => {
    const { q } = req.query;
    try {
        const searchUrl = `${DUCKDUCKGO_BASE_URL}?q=${encodeURIComponent(q)}`;

        const response = await axios.get(searchUrl, {
            headers: {
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
            }
        });
        const $ = cheerio.load(response.data);
        const results = [];
        // Extrai os resultados da página
        $('a.result__a').each((i, element) => {
            const $element = $(element);

            const title = $element.text().trim();

            // 2. O link é o atributo href.
            const rawLink = $element.attr('href');

            // O DuckDuckGo às vezes coloca URLs de rastreamento no href.
            // Precisamos garantir que estamos pegando a URL final.
            let finalLink = rawLink;

            if (rawLink && rawLink.includes('uddg=')) {
                const parts = rawLink.split('uddg=');
                finalLink = decodeURIComponent(parts[1]);
            }

            // Filtro final: só adiciona se houver título e link válido
            if (title && finalLink && (finalLink.startsWith('http') || finalLink.startsWith('https'))) {
                results.push({
                    titulo: title,
                    link: finalLink
                });
            }
        });
        // 4. Retorna o array de resultados em formato JSON
        return res.json(results);

    } catch (error) {
        console.error('Erro no Web Scraping:', error.message);
        return res.status(500).json({
            error: 'Erro ao processar a busca no motor externo.',
            details: error.message
        });
    }
});

// Inicia o servidor
app.listen(PORT, () => {
    console.log(`API de Pesquisa rodando na porta ${PORT}`);
    console.log(`Endpoint de teste: http://localhost:${PORT}/api/search?q=exemplo+flutter`);
});