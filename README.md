# 🗂️ Hands-On Lab: [Title, e.g., "Product Catalog with MongoDB" or "Social Network with Neo4j"]

**Unit Code:** MIT 8107  
**Course:** Advanced Database Systems  
**Date:** 30th July 2025  
**Group Members:**  
- Aicha Mbongo 
- Joel Mutevu 
- Brian Githenya 
- Alan 

---

<details>
<summary><strong>📘 A. Introduction</strong></summary>

Briefly introduce your chosen NoSQL data model. Include:

- What it is
- Why you chose it
- Its advantages over other models

</details>

---

<details>
<summary><strong>⚙️ B. Setup Instructions</strong></summary>

Use Docker for consistency and reproducibility.

<<<<<<< Updated upstream
### ✅ Example (MongoDB):
=======
## Prerequisites
- [Docker](https://docs.docker.com/get-docker/) installed on your machine

## 1. Install and Run Neo4j with Docker

1. Ensure Docker is running.
2. In the project directory, start Neo4j with:
   ```sh
   docker-compose up -d
   ```
   This uses the configuration in `docker-compose.yml` (Neo4j version 5.15).

## 2. Verify Neo4j Instance
- Open your browser and go to [http://localhost:7474](http://localhost:7474)
- Login with:
  - **Username:** neo4j
  - **Password:** 5trathm0re
- You should see the Neo4j Browser interface.

## 3. Connect to Neo4j (CLI/GUI)

### Web GUI (Neo4j Browser)
- Visit [http://localhost:7474](http://localhost:7474)
- Use the credentials above.

### CLI (cypher-shell)
- Install [cypher-shell](https://neo4j.com/docs/cypher-shell/current/)
- Connect with:
  ```sh
  cypher-shell -u neo4j -p 5trathm0re -a bolt://localhost:7687
  ```

# Option 2: Neo4j Docker Setup with PowerShell CLI



## Overview



This guide demonstrates how to set up Neo4j using Docker and connect to it via the Cypher shell using PowerShell CLI. This approach eliminates the need for authentication setup, making it ideal for development and testing environments.



## Prerequisites



- Docker installed and running on your system

- PowerShell terminal access

- Internet connection for downloading the Neo4j Docker image



## Setup Process



### Step 1: Run Neo4j Container



Execute the following Docker command to create and start a Neo4j container:



```powershell

docker run -d --name neo4j-linkedin -p 7474:7474 -p 7687:7687 -e NEO4J_AUTH=none neo4j:latest
>>>>>>> Stashed changes

```

<<<<<<< Updated upstream
### 📦 Include:
=======
>>>>>>> Stashed changes


#### Command Breakdown



- `docker run -d` - Runs the container in detached mode (background)

- `--name neo4j-linkedin` - Assigns a custom name to the container

- `-p 7474:7474` - Maps port 7474 for Neo4j Browser interface

- `-p 7687:7687` - Maps port 7687 for Bolt protocol connections

- `-e NEO4J_AUTH=none` - Disables authentication for easier development access

- `neo4j:latest` - Uses the latest Neo4j Docker image



### Step 2: Connect to Cypher Shell



Once the container is running, connect to the interactive Cypher shell:



```powershell

docker exec -it neo4j-linkedin cypher-shell

```



#### Command Breakdown



- `docker exec -it` - Executes an interactive command in the running container

- `neo4j-linkedin` - The name of our Neo4j container

- `cypher-shell` - The Neo4j command-line interface for executing Cypher queries



## Expected Output



### Docker Run Output

```

Unable to find image 'neo4j:latest' locally

latest: Pulling from library/neo4j

4f4fb700ef54: Pull complete

9f509846040c: Pull complete

605e668a097d: Pull complete

1337db2d4a82: Pull complete

ccaf924377f9: Pull complete

a21899da51b5: Pull complete

```



### Cypher Shell Connection

```

Connected to Neo4j using Bolt protocol version 5.8 at neo4j://localhost:7687.

Type :help for a list of available commands or :exit

neo4j@neo4j>

```



## 4. Troubleshooting
- **Port in use:** Make sure ports 7474 and 7687 are free or change them in `docker-compose.yml`.
- **Docker not running:** Start Docker Desktop or your Docker service.
- **Password issues:** To reset, stop containers, delete the `neo4j_data` volume, and restart:
  ```sh
  docker-compose down -v
  docker-compose up -d
  ```
- **Data persistence:** Data is stored in Docker volumes (`neo4j_data`).

## 5. Environment Management
- **Start Neo4j:**
  ```sh
  docker-compose up -d
  ```
- **Stop Neo4j:**
  ```sh
  docker-compose down
  ```
- **Remove all data:**
  ```sh
  docker-compose down -v
  ```

---
For further help, consult the [Neo4j Docker documentation](https://neo4j.com/docs/operations-manual/current/installation/docker/).

</details>

---

<details>
<summary><strong>🛠️ C. Basic CRUD Operations</strong></summary>

Demonstrate how to connect and run basic CRUD operations:

- **Create** (e.g., `insertOne`)
- **Read** (e.g., `find`)
- **Update** (e.g., `updateOne`)
- **Delete** (e.g., `deleteOne`)

Use context-specific examples like:

- MongoDB → Product catalog
- Neo4j → Friend relationships

```js
// MongoDB Insert Example
db.products.insertOne({
  name: "Laptop",
  price: 999,
  category: "Electronics"
});
```

Explain each command and expected result.

</details>

---

<details>
<summary><strong>🧩 D. Applied Scenario</strong></summary>

Describe a real-life scenario where your chosen model is useful. Include:

- A brief background of the problem
- Why the data model fits
- Sample data (structure and content)
- Example queries with output

</details>

---

<details>
<summary><strong>💻 E. Code & Commands</strong></summary>

All commands used must be:

- Clearly annotated
- Grouped by function (setup, insert, read, etc.)
- Tested and verified

```bash
# Example: Create a collection
db.createCollection("products")
```

Add comments above each command explaining its role.

</details>

---

<details>
<summary><strong>🖼️ F. Visuals and Output</strong></summary>

Screenshots are required for:

- Docker container running
- Terminal/CLI or GUI in action
- Before/after of CRUD operations
- UI dashboards (if any, like Neo4j browser, Mongo Express)

Embed images like this:

```markdown
![MongoDB running in Docker](images/mongo-docker.png)
```

Organize visuals in an `images/` folder.

</details>

---

<details>
<summary><strong>🧪 G. Clarity & Reproducibility</strong></summary>

Ensure:

- Steps can be followed from scratch
- No assumptions are made about prior setup
- All external dependencies are listed
- Version numbers are locked

> 🧼 Bonus Tip: Test the full setup on a new machine or VM.

</details>

---

<details>
<summary><strong>🧑‍🤝‍🧑 H. Collaboration Summary</strong></summary>

| Member Name | Main Contribution                          | Detailed Responsibilities                                                                                                                                                                       |
|-------------|--------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|Group member 1| Docker setup, environment configuration    | Set up Docker container or direct installation; ensure database instance runs correctly. This is critical to provide the environment for all other tasks.                                       |
|Group member 2| CRUD operations implementation and scripting| Write and test Create, Read, Update, Delete operations scripts and commands. This depends on the environment being ready.                                                                       |
| Aicha    | Scenario design and screenshots collection | Design the realistic scenario use case and take screenshots of outputs and interface to illustrate steps clearly.                                                                               |
| Group member 4 | Dataset creation and query optimization    | Develop sample datasets used for CRUD demos, optimize queries, and verify performance and correctness. Supports CRUD and scenario tasks.                                                        |

Each member must contribute meaningfully and be listed here.

</details>

---

## 📁 Supporting Files

Make sure your GitHub repo includes:

- 🐳 `docker-compose.yml` (optional)
- 📂 `datasets/` folder (JSON, CSV, etc.)
- 🖼️ `images/` folder (for screenshots)
- 🧾 `scripts/` folder (for helper scripts)
- 📄 `README.md` (this guide!)

---

## ✅ Final Submission Checklist

| Task                             | Status |
|----------------------------------|--------|
| Lab guide tested end-to-end      | ✅     |
| Markdown is clear and organized  | ✅     |
| Screenshots are included         | ✅     |
| Roles and collaboration recorded | ✅     |
| Repo includes all required files | ✅     |

---

