# Teste Técnico – Desenvolvimento de API e Cliente de Consumo
### Nessa documentação irei abordar como foi meu desenvolvimento sobre a API de pesquisas
***Desenvolvido por: Rafael Fassina dos Santos***
## Configurando o Backend
Para realizar essa API, eu utilizei como meu "backend", o NodeJS, que já tenho mais familiaridade com o JavaScript, do que com outras linguagens de programação como Java, PHP, Python, entre outras.

Para criar um projeto Node, precisamos primeiramente verificar se temos o **Node e o NPM** instalados em nossa máquina. Caso não tenha instalado o Node, basta acessar o site oficial **[NodeJS](https://nodejs.org/pt/download)**.

No meu caso, eu tenho instalado o **Chocolatey**, então rodei esse comando: ```choco install nodejs-lts -y```. Após isso, para verificar se foi instalado, basta rodar os comandos ```node --version``` e  ```npm --version```.
**(Se acaso não funcionar no PowerShell como administrador, tente rodar pelo CMD normal)**

### Observações
Se acaso os comandos não funcionarem, as vezes não está definido como uma variável de ambiente. Nesse caso, é simples, basta encontrar em qual caminho foi instalado o Node ***(Geralmente em Program Files)***, e adicionar dentro do Path, pesquisando no Windows, por *Variáveis de Ambiente*: ``` Path -> Editar -> Adicionar ```, e adicionar o caminho da pasta do node. ***Exemplo (C:\Program Files\nodejs\)***

## Rodando nosso Backend
Depois de ter feito a configuração do Node na máquina, é hora de rodar ele dentro do nosso projeto da API.
No projeto, contém duas pastas, a **frontend** e a **backend**. Para rodarmos nosso **backend**, precisamos entrar dentro da pasta, pelo terminal, usando ```cd .\backend\```, que ele deve aparecer no terminal como: ***\test-development\backend>***.
Após isso, precisamos instalar as dependências do Node, que por padrão, não sera 'upado' a pasta da *node_modules*. Para então baixarmos, basta rodarmos o comando: ```npm install``` ou ```npm i```, que funcionará da mesma forma. No final deve aparecer uma mensagem do tipo: 
```
added 102 packages, and audited 103 packages in 1s

34 packages are looking for funding
  run `npm fund` for details

found 0 vulnerabilities
``` 
Feito isso, basta rodarmos nosso backend com o comando:
```npm start``` ou ```node server.js```

No terminal, deve aparecer a seguinte mensagem:
```
API de Pesquisa rodando na porta 3000 
Endpoint de teste: http://localhost:3000/api/search?q=exemplo+flutter
```
Com nosso backend rodando, vamos configurar e ir para nosso Frontend, que é por lá que vamos consumir a API.

## Configurando o Frontend
Bom, como a vaga é para desenvolvedor mobile, decidi fazer em Flutter, para ir ganhando conhecimento e domínio na área. Antes de mais nada, como configuramos nosso backend, precisamos configurar nossa máquina para rodar o nosso frontend.
Caso na máquina não tenha instalado o Flutter, pode estar baixando pelo site do [Flutter](https://docs.flutter.dev/install/manual), ou se preferir, pode instalar a extensão do Flutter dentro do **VS Code** ( foi o meu caso).
Se optar por instalar pelo VS Code, ele pede para localizar a pasta que foi instalado o SDK do flutter (geralmente cria uma pasta chamada **scr** dentro do **Disco C:** e extrai o download do flutter e coloca lá), se caso tiver, basta clicar em locate SDK.
* Se estiver rodando o projeto dentro do **Android Studio**, basta clicar em ```Settings -> Languages & Frameworks -> Flutter```, e localizar a pasta do SDK do flutter.

Recomendo sempre antes de rodar o comando **pub dev**, rodar o comando ```flutter clean``` para garantir que não ocorra nenhum erro ao fazer o build.
Feito isso, ele já automaticamente sugere para rodar o comando **pub dev**, para instalar as dependências que foi utilizada no projeto. Se acaso sumir a mensagem, basta rodar o comando ```flutter pub get```. **(Observação):** Como o projeto está divido em duas pastas, uma front e a outra back, para rodar o flutter, precisa entrar dentro da pasta frontend para rodar o comando: ```cd .\frontend\```. **Exemplo: \test-development\frontend.**

Feito tudo isso, para rodarmos nosso projeto, basta rodar o comando ```flutter run -d chrome``` que ele inicia o projeto na Web, e caso queira rodar no emulador android, basta rodar o comando ```flutter run```
### Observações:
No projeto, utilizei a api para rodar no **emulador Android**, então, dentro do arquivo **search_api_service**, na linha 7: ```final String baseUrl = 'http://10.0.2.2:3000/api/search';```, está a URL para rodar em emuladores Android, caso desejem rodar na Web, basta trocar a URL para o localhost:
``` final String = "http://localhost:3000/api/search";```

## Conclusões
Bom, espero que tenham compreendido e ter conseguido rodar o projeto na máquina, só alguns pontos que gostariam de ressaltar é que separei os arquivos, para uma melhor organização de código, onde tem a **service**, **model** e **view**. Como é um projeto "simples e pequeno", não utilizei a estrutura MVVM, para não dificultar tanto.
No código main, importei a classe MyAppF, onde contém o título do projeto, que geralmente se colocam dentro da main.
Agradeço a oportunidade, e espero o retorno de vocês.
