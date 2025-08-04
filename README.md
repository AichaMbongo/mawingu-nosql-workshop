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

### ✅ Example (MongoDB):

```bash
docker run --name mongodb -d -p 27017:27017 mongo:7.0
```

### 📦 Include:

- Installation steps for Docker (if needed)
- Version numbers for the NoSQL tool and any GUIs
- Optional: Docker Compose setup

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

