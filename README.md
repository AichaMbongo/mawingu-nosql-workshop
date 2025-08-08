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
  category: "Electronics",
});
```

Explain each command and expected result.

</details>

---

<details>
<summary><strong>🧩 D. Applied Scenario</strong></summary>

## 🧩 Real-Life Scenario: Professional Networking and Recommendations on LinkedIn

---

### 🔍 Background of the Problem

In professional social networks like **LinkedIn**, users seek to:

- Connect with other professionals
- Find job opportunities
- Endorse skills
- Join relevant groups

The platform requires an efficient way to store and query **complex relationships**—like user connections, employment history, skill endorsements, and group memberships—to provide personalized recommendations and insights.

---

### 🧠 Why the Graph Data Model Fits

Graph databases naturally model relationships between entities using **nodes** and **edges**, making them ideal for highly interconnected data.

- 👤 **Nodes**: Users, Companies, Skills, Groups
- 🔗 **Edges**: Friendships, Employment, Endorsements, Group Memberships

**Benefits:**

- Easy traversal for “friends of friends” queries
- Efficient skill matching and community detection
- Superior performance in recursive and join-like queries

> Unlike relational databases, graph databases **excel at relationship traversal** and perform better for deeply nested queries.

---

### 📦 Sample Data (Structure and Content)

#### 🔹 Nodes

| Node Type | Attributes                      |
| --------- | ------------------------------- |
| User      | `userID`, `name`, `headline`    |
| Company   | `companyID`, `name`, `industry` |
| Skill     | `skillID`, `name`               |
| Group     | `groupID`, `name`, `field`      |

#### 🔸 Relationships

| Relationship Type | Description                           |
| ----------------- | ------------------------------------- |
| `CONNECTED_TO`    | User ↔ User (Professional connection) |
| `WORKS_AT`        | User → Company                        |
| `ENDORSED`        | User → Skill                          |
| `MEMBER_OF`       | User → Group                          |

---

### 🧪 Example Data

#### 🧍 Nodes

```json
User: { "userID": 1, "name": "Wanjiku Mwangi", "headline": "Software Engineer" }
Company: { "companyID": 101, "name": "Nairobi Tech Hub", "industry": "Software" }
Skill: { "skillID": 201, "name": "Python" }
Group: { "groupID": 301, "name": "AI in Africa", "field": "Technology" }
```

#### 🔗 Relationships

```plaintext
Wanjiku —CONNECTED_TO→ Otieno
Wanjiku —WORKS_AT→ Nairobi Tech Hub
Otieno —ENDORSED→ Python
Achieng —MEMBER_OF→ AI in Africa
```

---

### 🔎 Example Queries with Output

#### 1. Find friends of a user (2nd-degree connections):

```cypher
MATCH (user:User {name: "Wanjiku Mwangi"})-[:CONNECTED_TO]->(:User)-[:CONNECTED_TO]->(fof)
WHERE NOT (user)-[:CONNECTED_TO]->(fof) AND user <> fof
RETURN DISTINCT fof.name AS RecommendedConnections
```

**Output:**

| RecommendedConnections |
| ---------------------- |
| Brian Kiptoo           |
| Aisha Mohamed          |

---

#### 2. List skills endorsed for a user:

```cypher
MATCH (user:User {name: "Otieno Ouma"})-[:ENDORSED]->(skill)
RETURN skill.name AS Skills
```

**Output:**

| Skills |
| ------ |
| Python |
| Java   |

---

#### 3. Find users who work at the same company:

```cypher
MATCH (u1:User)-[:WORKS_AT]->(company {name: "Nairobi Tech Hub"})<-[:WORKS_AT]-(u2:User)
WHERE u1.name = "Wanjiku Mwangi" AND u1 <> u2
RETURN u2.name AS Colleagues
```

**Output:**

| Colleagues    |
| ------------- |
| Achieng Njeri |

---

#### 4. Find communities (groups) a user is a member of:

```cypher
MATCH (user:User {name: "Achieng Njeri"})-[:MEMBER_OF]->(group)
RETURN group.name AS Groups
```

**Output:**

| Groups       |
| ------------ |
| AI in Africa |

---

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

| Member Name | Main Contribution                            | Detailed Responsibilities                                                                                                                                                                                                                                                                                                                                                                  |
| ----------- | -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Allan       | Docker setup, environment configuration      | 1. Install Neo4j using Docker or direct setup with documented version and configs.<br>2. Verify Neo4j instance runs.<br>3. Provide connection instructions for team (CLI/GUI).<br>4. Troubleshoot setup issues.<br>5. Document environment setup clearly in the lab manual.                                                                                                                |
| Brian       | CRUD operations implementation and scripting | 1. Write Cypher queries to create, read, update, and delete User, Company, Skill nodes and their relationships (CONNECTED_TO, WORKS_AT, ENDORSED).<br>2. Test each CRUD operation with the sample dataset.<br>3. Annotate queries with comments for clarity.<br>4. Work closely withJoel to ensure queries align with dataset structure.                                                   |
| Aicha       | Scenario design and screenshots collection   | 1. Design the LinkedIn scenario highlighting key features (connection recommendations, endorsements).<br>2. Draft clear, beginner-friendly explanations.<br>3. Collect screenshots of query results and database outputs.<br>4. Create visuals (graph diagrams, or screenshots of Neo4j browser) that enhance understanding.<br>5. Organize scenario walkthrough logically.                |
| Joel        | Dataset creation and query optimization      | 1. Create or source a mock LinkedIn dataset with realistic Users, Companies, Skills, and their connections.<br>2. Format data for easy Neo4j import (CSV/JSON).<br>3. Collaborate with Brian to align dataset structure with CRUD queries.<br>4. Optimize query performance by suggesting indexes or refactoring.<br>5. Test dataset with team and verify all lab operations run smoothly. |

                                                                                                                                                                   |

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
| -------------------------------- | ------ |
| Lab guide tested end-to-end      | ✅     |
| Markdown is clear and organized  | ✅     |
| Screenshots are included         | ✅     |
| Roles and collaboration recorded | ✅     |
| Repo includes all required files | ✅     |

---
