# SneezePharmaBD 💊

Este repositório contém o projeto de banco de dados para o sistema de gerenciamento da farmácia SneezePharma. O banco foi desenvolvido em T-SQL para ser executado no SQL Server.

![Status do Projeto](https://img.shields.io/badge/Status-Em%20Desenvolvimento-yellow)

## 📖 Sobre o Projeto

O `SneezePharmaBD` é um banco de dados relacional projetado para dar suporte a todas as operações de uma farmácia, incluindo o gerenciamento de clientes, produtos, estoque e vendas.

## 🏛️ Estrutura do Banco

O banco de dados segue um modelo relacional padrão, com entidades principais como:

* **Clientes:** Cadastro de compradores.
* **Medicamentos/Produtos:** Informações e controle de estoque.
* **Fornecedores:** De onde vêm os produtos.
* **Vendas:** Tabela principal que registra uma transação (Cabeçalho da Venda).
* **ItensVenda:** Tabela detalhada que liga cada Venda aos Produtos vendidos (Corpo da Venda).
* _(Adicione outras tabelas importantes aqui)_

## 🛠️ Tecnologias Utilizadas

* **SGBD:** SQL Server
* **Linguagem:** T-SQL
* **IDE:** SQL Server Management Studio (SSMS)

## 🚀 Como Rodar o Projeto (Instruções)

Para recriar o banco de dados na sua máquina local, siga os passos abaixo.

### Pré-requisitos

* [SQL Server](https://www.microsoft.com/pt-br/sql-server/sql-server-downloads) (Qualquer edição, ex: Express ou Developer).
* [SQL Server Management Studio (SSMS)](https://learn.microsoft.com/pt-br/sql/ssms/download-sql-server-management-studio-ssms).

### ‼️ Importante: Como Abrir os Scripts

Este repositório contém scripts `.sql` (e não um arquivo de projeto `.sln` do Visual Studio). O SSMS não "abre" uma pasta de projeto; ele executa scripts.

A forma correta de usar este repositório é:

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/kihus/SneezePharmaBD.git
    ```

2.  **Abra o SSMS:**
    Conecte-se à sua instância local do SQL Server (ou qualquer servidor que você tenha acesso).

3.  **Execute os Scripts:**
    * No Windows Explorer, navegue até a pasta onde você clonou o repositório (`.../SneezePharmaBD`).
    * **Arraste e solte** (drag and drop) os arquivos `.sql` (ex: `01_Tabelas.sql`, `02_Dados.sql`, etc.) diretamente para dentro da janela do SSMS.
    * Execute os scripts na ordem correta! ([...]Tables, [...]ForeignKeys, [...]Triggers, [...]Generics)
      
## 📊 Modelagem do Banco

Para uma visão mais visual da arquitetura e dos relacionamentos do SneezePharmaBD, consulte os diagramas do projeto:

* **[🔗 Modelo Lógico no draw.db](https://www.drawdb.app/editor?shareId=2e87dd64da3f3de7eec47b64d4f81791)**
    * *Visão de alto nível das tabelas e como elas se relacionam.*

* **[🔗 Modelo Entidade-Relacionamento (MER) no Excalidraw](https://excalidraw.com/#json=tAaZSDh2KzVDcHumkgcRs,YG3ez_XD3ty49RcfM3uhkg)**
    * *Diagrama detalhado mostrando as entidades, atributos e cardinalidade.*
