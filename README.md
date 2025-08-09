# Hands-On Lab: [Title, e.g., "Product Catalog with MongoDB" or "Social Network with Neo4j"]

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
<summary><strong>A. Introduction</strong></summary>

Briefly introduce your chosen NoSQL data model. Include:

- What it is
- Why you chose it
- Its advantages over other models

</details>

---

<details>
<summary><strong>B. Setup Instructions</strong></summary>

Use Docker for consistency and reproducibility.

###Example (MongoDB):

```bash
docker run --name mongodb -d -p 27017:27017 mongo:7.0
```

### Include:

- Installation steps for Docker (if needed)
- Version numbers for the NoSQL tool and any GUIs
- Optional: Docker Compose setup

</details>

---

<details>
<summary>
<strong> Neo4j Graph Database CRUD Operations</strong>
</summary>



## LinkedIn Professional Network 

### Understanding Graph Database

Graph databases revolutionize how we model and query connected data. Unlike traditional relational databases that struggle with complex relationships, Neo4j excels at representing real-world connections naturally. In our LinkedIn-inspired professional network, we'll explore how nodes (professionals, companies, skills) connect through meaningful relationships (connections, employment, endorsements).

**Why Graph Databases Matter:**
- **Natural Modeling**: Relationships are first-class citizens, not foreign key afterthoughts
- **Performance**: Traversing connections is blazingly fast, regardless of data size  
- **Flexibility**: Schema-optional design adapts as your network evolves
- **Pattern Discovery**: Uncover hidden connections and insights through sophisticated queries

---

## Data Model Architecture

Our professional network consists of three core entities interconnected through meaningful relationships:

### Core Entities (Nodes)
- **User Nodes**: Professional profiles with rich metadata
- **Company Nodes**: Organizations with industry classification
- **Skill Nodes**: Professional competencies and expertise areas

### Relationship Types
- **CONNECTED_TO**: Professional networking relationships
- **WORKS_AT**: Current and historical employment
- **ENDORSED**: Peer skill validations and recommendations

*Neo4j Browser showing the graph schema visualization*
![Neo4j Layout](https://raw.githubusercontent.com/AichaMbongo/mawingu-nosql-workshop/refs/heads/main/GeneralGraphs.jpg)

---

## CREATE Operations: Building Your Professional Network

### Step 1: Establishing User Profiles

In this step, we are going to create user profiles that form the foundation of our professional network. Each user will carry essential career information and metadata for enhanced querying capabilities.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Create diverse professional profiles with rich metadata
WITH [
  {name: "Alice Johnson", email: "alice.johnson@email.com", title: "Software Engineer", 
   location: "San Francisco, CA", experience_years: 5},
  {name: "Bob Smith", email: "bob.smith@email.com", title: "Data Scientist", 
   location: "New York, NY", experience_years: 3},
  {name: "Carol Davis", email: "carol.davis@email.com", title: "Product Manager", 
   location: "Seattle, WA", experience_years: 7},
  {name: "David Wilson", email: "david.wilson@email.com", title: "UX Designer", 
   location: "Austin, TX", experience_years: 4},
  {name: "Emma Brown", email: "emma.brown@email.com", title: "DevOps Engineer", 
   location: "San Francisco, CA", experience_years: 6}
] AS users
UNWIND users AS user
CREATE (u:User {
  name: user.name,
  email: user.email,
  title: user.title,
  location: user.location,
  experience_years: user.experience_years,
  created_at: datetime(),
  profile_completion: 85
})
RETURN u.name, u.title, u.location;
```

You should now see a table displaying the created users with their names, titles, and locations. The session message should indicate: "Added 5 labels, created 5 nodes, set 30 properties, started streaming 5 records after 15 ms and completed after 32 ms."

![Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/Creating%20the%20tables.png)

### Step 2: Building Company Ecosystem

Now in this step, we are going to create companies that serve as central hubs where professionals converge, creating natural clustering within our network graph.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Establish diverse company profiles across industries
WITH [
  {name: "TechCorp Inc", industry: "Technology", location: "San Francisco, CA", 
   size: "1000-5000", founded: 2010, description: "Leading technology solutions provider"},
  {name: "Data Solutions LLC", industry: "Analytics", location: "New York, NY", 
   size: "100-500", founded: 2015, description: "Advanced analytics and insights"},
  {name: "Creative Design Studio", industry: "Design", location: "Austin, TX", 
   size: "50-100", founded: 2018, description: "Award-winning design experiences"}
] AS companies
UNWIND companies AS company
CREATE (c:Company {
  name: company.name,
  industry: company.industry,
  location: company.location,
  size: company.size,
  founded: company.founded,
  description: company.description
})
RETURN c.name, c.industry, c.size;
```

*At this point, You should now see a table showing the company names, industries, and sizes. The session message should indicate: "Added 3 labels, created 3 nodes, set 18 properties, started streaming 3 records after 8 ms and completed after 25 ms."*

### Step 3: Defining Professional Skills

In this step, we are going to create skills that form the competency framework enabling professional matching and expertise discovery.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Create comprehensive skill taxonomy
WITH [
  {name: "Python", category: "Programming"},
  {name: "Java", category: "Programming"},
  {name: "Machine Learning", category: "Data Science"},
  {name: "UI Design", category: "Design"},
  {name: "Project Management", category: "Management"},
  {name: "Docker", category: "DevOps"},
  {name: "Kubernetes", category: "DevOps"}
] AS skills
UNWIND skills AS skill
CREATE (s:Skill {
  name: skill.name,
  category: skill.category,
  popularity_score: toInteger(rand() * 100)
})
RETURN s.name, s.category;
```

*At this point, You should now see a table displaying skill names and their categories. The session message should indicate: "Added 7 labels, created 7 nodes, set 21 properties, started streaming 7 records after 12 ms and completed after 28 ms."*
#### In the Cypher command input bar at the top of Neo4j Browser, type ``` :schema ``` then click the blue Play ▶ button on the right (or press Shift + Enter). Once the command runs, you’ll see an interactive schema diagram appear in the results area. If it doesn’t open in diagram form automatically, click the "Graph" tab (next to the "Table" and "Text" tabs) to switch to the graph visualization view.
![GRAPH VISUAL SCHEME](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/Creating%20the%20tables.png)

### Step 4: Creating Professional Connections

Now, we are going to establish professional connections between users. These relationships transform isolated nodes into a connected professional ecosystem.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Establish professional connections with relationship metadata
MATCH (alice:User {name: "Alice Johnson"}), (bob:User {name: "Bob Smith"})
CREATE (alice)-[:CONNECTED_TO {
  connected_date: date(), 
  mutual_connections: 15,
  connection_strength: "Strong",
  last_interaction: date()
}]->(bob)

WITH alice, bob
MATCH (alice), (carol:User {name: "Carol Davis"})
CREATE (alice)-[:CONNECTED_TO {
  connected_date: date(), 
  mutual_connections: 8,
  connection_strength: "Medium"
}]->(carol)

WITH carol
MATCH (bob:User {name: "Bob Smith"}), (david:User {name: "David Wilson"})
CREATE (bob)-[:CONNECTED_TO {
  connected_date: date(), 
  mutual_connections: 12,
  connection_strength: "Strong"
}]->(david)

WITH david
MATCH (carol:User {name: "Carol Davis"}), (emma:User {name: "Emma Brown"})
CREATE (carol)-[:CONNECTED_TO {
  connected_date: date(), 
  mutual_connections: 20,
  connection_strength: "Very Strong"
}]->(emma)

RETURN "Professional connections created" AS status;
```

You should see a status message confirming creation. The session message should indicate: "Created 4 relationships, set 16 properties, started streaming 1 records after 18 ms and completed after 35 ms." 
NB: The exact timing may vary depending on the machine and the network.

### Step 5: Creating Employment Relationships

Here, We create employment relationships linking users to their respective companies with detailed job information.

Copy and paste the following code in the Neo4j terminal window to run:

```js

// Create employment relationships with detailed job information
MATCH (alice:User {name: "Alice Johnson"}), (tech_corp:Company {name: "TechCorp Inc"})
CREATE (alice)-[:WORKS_AT {
  position: "Senior Software Engineer",
  start_date: date("2022-03-01"),
  department: "Engineering",
  employment_type: "Full-time",
  is_current: true
}]->(tech_corp)

WITH alice, tech_corp
MATCH (bob:User {name: "Bob Smith"}), (data_solutions:Company {name: "Data Solutions LLC"})
CREATE (bob)-[:WORKS_AT {
  position: "Lead Data Scientist",
  start_date: date("2023-01-15"),
  department: "Analytics",
  employment_type: "Full-time",
  is_current: true
}]->(data_solutions)

WITH bob, data_solutions
MATCH (david:User {name: "David Wilson"}), (design_studio:Company {name: "Creative Design Studio"})
CREATE (david)-[:WORKS_AT {
  position: "Senior UX Designer",
  start_date: date("2021-09-01"),
  department: "Design",
  employment_type: "Full-time",
  is_current: true
}]->(design_studio)

RETURN "Employment relationships created" AS status;
```

You will see a status message confirming creation. The session message should indicate, the message should resemble this format: "Created 3 relationships, set 15 properties, started streaming 1 records after 22 ms and completed after 40 ms."

*Neo4j Browser showing relationship types*
![Final Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/Creating%20the%20tables.png)

---

## READ Operations: Discovering Network Insights

### Step 6: Basic User Profile Queries

Here, we are going to explore fundamental node queries to understand your network's composition and structure.

> Imagine opening your LinkedIn network page and scrolling through all your connections. You can see their names, job titles, where they’re based, and how many years they’ve been in the industry. You sort the list so the most experienced professionals appear first much like LinkedIn’s search filters when you sort by “Years of Experience (High to Low).” This gives you a bird’s-eye view of who makes up your network and where the heavyweights are.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Comprehensive user profile analysis
MATCH (u:User) 
RETURN u.name, u.title, u.location, u.experience_years
ORDER BY u.experience_years DESC;
```

**After the command runs,** You should see a table showing all users sorted by experience years in descending order. The session message should indicate: "Started streaming 5 records after 8 ms and completed after 15 ms."

*Query results showing user profiles in tabular format*
![Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/step6.png)

### Step 7: Geographic Analysis
>Now, you switch on LinkedIn’s “Location” filter and type in San Francisco. Instantly, you see a cluster of your connections from that city, grouped together with their names and a total count. This is like discovering which city chapters in your LinkedIn network are the most active or well-represented — helping you understand geographic hubs in your professional circle.
Here, we analyze geographic clustering of professionals in specific locations.


Copy and paste the following code in the Neo4j terminal window to run:

```js
// Geographic clustering analysis
MATCH (u:User)
WHERE u.location CONTAINS "San Francisco"
WITH u.location AS city, collect(u.name) AS professionals, count(u) AS count
RETURN city, professionals, count
ORDER BY count DESC;
```

**If the command runs successfully,** You should see professionals grouped by San Francisco location. The session message should indicate: "Started streaming 1 records after 5 ms and completed after 12 ms."

### Step 8: Professional Connection Analysis

Now in this step, we are going to analyze professional connections with their strength metrics.

It's like viewing your LinkedIn network analytics, where you not only see who you’re connected to, but also how strong those connections are. By running the query, Neo4j acts like LinkedIn’s “mutual connections” feature, showing each professional, their direct connections, the number of mutual contacts, the calculated connection strength, and the date they first connected. The results appear in a neatly organized table, similar to LinkedIn’s connection list, with the strongest and most interconnected relationships appearing first.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Professional connection analysis with strength metrics
MATCH (u1:User)-[r:CONNECTED_TO]-(u2:User)
RETURN u1.name AS Professional, 
       u2.name AS Connection,
       r.mutual_connections AS MutualConnections,
       r.connection_strength AS Strength,
       r.connected_date AS ConnectedSince
ORDER BY r.mutual_connections DESC;
```

>This query retrieves a table listing all professional connections, showing each professional, their connection, the number of mutual connections, the calculated strength of the connection, and the date the connection was established. Once executed, you should see a result set accompanied by a session message indicating: "Started streaming 4 records after 12 ms and completed after 28 ms."

*Network visualization highlighting connection strengths*
![Final Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/Proffessional%20Connections%20analysis8.png)

### Step 9: Employment Landscape Analysis

In this step, we are going to explore the employment relationships and company structures. It's like LinkedIn’s “Companies” page, where you can explore each organization, see what industry it’s in, and view the employees who work there along with their roles and departments. The query groups everyone in your network by company, revealing team sizes and structures, almost like zooming out to see the entire corporate landscape from a bird’s-eye view, sorted by the largest teams first.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Employment landscape and career paths
MATCH (u:User)-[r:WORKS_AT]->(c:Company)
WITH c.name AS company, c.industry AS industry, 
     collect({name: u.name, position: r.position, department: r.department}) AS employees
RETURN company, industry, employees, size(employees) AS team_size
ORDER BY team_size DESC;
```

>**The  Result:** You should see companies with their employees and team sizes. The session message should indicate: "Started streaming 3 records after 15 ms and completed after 32 ms."

### Step 10: Network Recommendations

Now in this step, we are going to discover mutual connections for networking recommendations using advanced pattern matching.

This is like LinkedIn’s “People You May Know” feature, but smarter. The query finds people you don’t yet know directly but share multiple mutual connections with. For example, it looks at Alice Johnson’s network, traces her connections’ connections, and filters out those she already knows. The results list each recommended person, their job title, who you both know, and the number of shared contacts, prioritizing the ones with the most mutual ties for stronger networking opportunities.

Copy and paste the following code in the Neo4j terminal window to run:

```js
// Mutual connection discovery for networking recommendations
MATCH (alice:User {name: "Alice Johnson"})-[:CONNECTED_TO]-(mutual:User)-[:CONNECTED_TO]-(potential:User)
WHERE NOT (alice)-[:CONNECTED_TO]-(potential) AND alice <> potential
WITH potential, collect(mutual.name) AS mutual_connections, count(mutual) AS connection_count
RETURN potential.name AS RecommendedConnection,
       potential.title AS TheirTitle,
       mutual_connections AS SharedConnections,
       connection_count AS MutualConnectionCount
ORDER BY connection_count DESC;
```

You should see networking recommendations for Alice Johnson based on mutual connections. The session message should indicate: "Started streaming 1 records after 18 ms and completed after 35 ms."

*Screenshot Placeholder: Query results showing networking recommendations*
![Final Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/Career_Progression_Updates.png)

---

## UPDATE Operations: Evolving Professional Profiles

### Step 11: Career Progression Updates

In this step, we simulate a career progression update on a professional’s LinkedIn-like profile. Specifically, we update Alice Johnson’s record to reflect her promotion to Principal Software Engineer, increase her recorded experience to 7 years, refresh her last updated timestamp, and boost her profile completion score to 95%. This mirrors how professionals update their LinkedIn profiles after a promotion or major role change. To execute this in Neo4j, run the following:

```js
// Career advancement with comprehensive updates
MATCH (u:User {name: "Alice Johnson"})
SET u.title = "Principal Software Engineer",
    u.experience_years = 7,
    u.last_updated = datetime(),
    u.profile_completion = 95
RETURN u.name, u.title, u.experience_years, u.profile_completion;
```

**Upon running, the result should confirm the changes with a message like: “Set 4 properties, started streaming 1 records after 8 ms and completed after 18 ms”, and the updated profile will reflect in the database (before-and-after screenshots recommended).**

*Screenshot Placeholder: Before and after profile comparison*

### Step 12: Company Information Updates

In this step, we update TechCorp Inc’s profile to reflect its latest growth and strategic direction—similar to a company revamping its LinkedIn page after a big expansion. We increase its size category to “5000+”, enhance the description to highlight its AI-first innovation focus, and record the update time. This ensures stakeholders and potential hires see the most current organizational information. Run the following:

```js
// Company growth and evolution
MATCH (c:Company {name: "TechCorp Inc"})
SET c.size = "5000+",
    c.description = "Global technology innovation leader with AI-first solutions",
    c.last_updated = datetime()
RETURN c.name, c.size, c.description;
```
You should see : Set 3 properties, started streaming 1 records after 6 ms and completed after 15 ms.” confirming the company’s refreshed digital presence.

### Step 13: Relationship Metadata Updates

Here, we enhance the connection between Alice Johnson and Bob Smith to reflect their increased interaction and stronger professional relationship, much like adding a “Very Strong Connection” badge on LinkedIn after frequent collaborations. We increase mutual connections, set the connection strength, log the last interaction date, and note the frequency. Run:

```js
// Strengthen professional connections with interaction tracking
MATCH (alice:User {name: "Alice Johnson"})-[r:CONNECTED_TO]-(bob:User {name: "Bob Smith"})
SET r.mutual_connections = 22,
    r.connection_strength = "Very Strong",
    r.last_interaction = date(),
    r.interaction_frequency = "Weekly"
RETURN alice.name, bob.name, r.connection_strength, r.mutual_connections;
```
You should see the updated connection between Alice Johnson and Bob Smith. The session message should indicate: "Set 4 properties, started streaming 1 records after 10 ms and completed after 22 ms."

### Step 14: Bulk Profile Enhancements

Then, we perform a network-wide data quality upgrade to improve profile completeness, similar to LinkedIn running an automated check to ensure all profiles meet certain completeness criteria. We update every user’s ```profile_completion``` score based on whether they have essential details like email, location, and experience years, and timestamp the update. Run:

```js
// Network-wide profile completion scoring
MATCH (u:User)
SET u.profile_completion = CASE 
  WHEN u.email IS NOT NULL AND u.location IS NOT NULL AND u.experience_years > 0 
  THEN 90 
  ELSE 70 
END,
u.last_profile_update = datetime()
RETURN u.name, u.profile_completion, u.last_profile_update;
```

**Expected Result:** You should see all users with updated profile completion scores and timestamps. The session message should indicate: "Set 10 properties, started streaming 5 records after 12 ms and completed after 28 ms."

*Updated node properties in Neo4j Browser*
![Updated node](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/14Bulkenhancement.png)

---

## DELETE Operations: Network Maintenance

### Step 15: Removing Professional Connections

Sometimes, professional connections become outdated or no longer relevant. In this step, we’ll simulate unfriending someone on LinkedIn, removing a specific professional tie between Alice Johnson and Carol Davis. This keeps the network clean and accurate. Run:

```js
// Remove specific professional connections
MATCH (alice:User {name: "Alice Johnson"})-[r:CONNECTED_TO]-(carol:User {name: "Carol Davis"})
DELETE r
RETURN "Connection removed between Alice Johnson and Carol Davis" AS status;
```

You should see a status message confirming the deletion. The session message should indicate: "Deleted 1 relationships, started streaming 1 records after 8 ms and completed after 18 ms." ,  confirming the connection has been removed.

*Graph after relationship deletion*
![Final Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/15Removing%20Proffessional%20relationships.png)

### Step 16: Safe Node Removal with Relationships

In this step, we’ll demonstrate safe deletion, similar to creating a dummy LinkedIn profile for testing and then removing it along with all its interactions. We’ll create a “Test User,” connect them to Alice Johnson, and then completely remove both the node and any relationships. Run:

```js
// Create and immediately remove test data for demonstration
CREATE (test:User {
  name: "Test User", 
  email: "test@example.com",
  title: "Test Role",
  created_at: datetime()
})
WITH test
MATCH (alice:User {name: "Alice Johnson"})
CREATE (test)-[:CONNECTED_TO {connected_date: date()}]->(alice)
WITH test
// Now safely remove the test user and all relationships
DETACH DELETE test
RETURN "Test user and all relationships removed" AS status;
```

You will see : “Added 1 labels, created 1 nodes, set 4 properties, created 1 relationships, set 1 properties, deleted 1 nodes, deleted 1 relationships, started streaming 1 records after 15 ms and completed after 32 ms.”;confirming a full cleanup.

### Step 17: Conditional Data Cleanup

Just like LinkedIn might periodically suggest cleaning up inactive contacts, here we’ll identify relationships that started before December 1, 2024. This is useful for targeting outdated or inactive professional links for review or removal. Run:

```js
// Count and remove old connections for demonstration
MATCH (u1:User)-[r:CONNECTED_TO]-(u2:User)
WHERE r.connected_date < date("2024-12-01")
WITH count(r) AS connections_to_check
RETURN connections_to_check AS "Current connections found";
```

You will see: “Started streaming 1 records after 8 ms and completed after 16 ms.” — giving you a count of old connections to consider pruning.
*Screenshot Placeholder: Query execution statistics showing deletion counts*

---

## Advanced Network Analysis Queries

### Step 18: Network Influencer Identification

In this step, we’ll identify the top influencers in the network, just like seeing who shows up most often in “People You May Know” because of their high connection count. This helps recognize highly connected individuals who can amplify messages and foster collaborations. Run:

```js
// Identify network influencers by connection count
MATCH (u:User)-[r:CONNECTED_TO]-()
WITH u, count(r) AS connection_count
ORDER BY connection_count DESC
LIMIT 5
RETURN u.name AS Influencer, u.title AS Role, connection_count AS Connections;
```

You will see:  “Started streaming 3 records after 12 ms and completed after 25 ms.”, revealing the top five most connected professionals.

### Step 19: Professional Matching Analysis

Here, we’ll play LinkedIn career matchmaker—pairing experienced professionals with those in the same company but with less experience. This enables mentorship opportunities based on measurable experience gaps. Run:

```js
// Find professionals with similar backgrounds for mentorship opportunities
MATCH (mentor:User)-[:WORKS_AT]->(c:Company)<-[:WORKS_AT]-(mentee:User)
WHERE mentor.experience_years > mentee.experience_years + 1
RETURN mentor.name AS Mentor, 
       mentee.name AS Mentee,
       c.name AS Company,
       (mentor.experience_years - mentee.experience_years) AS ExperienceGap
ORDER BY ExperienceGap DESC;
```

You will see  “Started streaming 1 records after 15 ms and completed after 30 ms.”, listing potential mentor-mentee pairs with clear skill gaps.

*Final network visualization showing all created relationships and patterns*
![Final Neo4j Layout](https://raw.githubusercontent.com/EngineerClout/GRAPHMODEL_SCREENSHOTS/refs/heads/main/graph.png)

---

## Key Takeaways

Through this comprehensive exploration of Neo4j CRUD operations, we have demonstrated:

- **Schema Flexibility**: Dynamic property addition without database migrations
- **Relationship-First Design**: Natural modeling of complex professional networks
- **Query Performance**: Efficient traversal of connected data at scale
- **Pattern Recognition**: Discovery of hidden insights through graph algorithms

>*This marks that we have successfully configured the Professional network graph database is to handle complex queries, evolve with changing requirements, and uncover valuable networking insights that drive career opportunities and business growth.*

</details>
<details>

<summary><strong> D. Applied Scenario</strong></summary>

##  Real-Life Scenario: Professional Networking and Recommendations on LinkedIn

---

###  Background of the Problem

In professional social networks like **LinkedIn**, users seek to:

- Connect with other professionals
- Find job opportunities
- Endorse skills
- Join relevant groups

The platform requires an efficient way to store and query **complex relationships**—like user connections, employment history, skill endorsements, and group memberships—to provide personalized recommendations and insights.

---

### Why the Graph Data Model Fits

Graph databases naturally model relationships between entities using **nodes** and **edges**, making them ideal for highly interconnected data.

-  **Nodes**: Users, Companies, Skills, Groups
-  **Edges**: Friendships, Employment, Endorsements, Group Memberships

**Benefits:**

- Easy traversal for “friends of friends” queries
- Efficient skill matching and community detection
- Superior performance in recursive and join-like queries

> Unlike relational databases, graph databases **excel at relationship traversal** and perform better for deeply nested queries.

---

### Sample Data (Structure and Content)

####  Nodes

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

###  Example Data

####  Nodes

```json
User: { "userID": 1, "name": "Wanjiku Mwangi", "headline": "Software Engineer" }
Company: { "companyID": 101, "name": "Nairobi Tech Hub", "industry": "Software" }
Skill: { "skillID": 201, "name": "Python" }
Group: { "groupID": 301, "name": "AI in Africa", "field": "Technology" }
```

####  Relationships

```plaintext
Wanjiku —CONNECTED_TO→ Otieno
Wanjiku —WORKS_AT→ Nairobi Tech Hub
Otieno —ENDORSED→ Python
Achieng —MEMBER_OF→ AI in Africa
```

---

###  Example Queries with Output

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
<summary><strong> E. Code & Commands</strong></summary>

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
<summary><strong>F. Visuals and Output</strong></summary>

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
<summary><strong> G. Clarity & Reproducibility</strong></summary>

Ensure:

- Steps can be followed from scratch
- No assumptions are made about prior setup
- All external dependencies are listed
- Version numbers are locked

>  Bonus Tip: Test the full setup on a new machine or VM.

</details>

---

<details>
<summary><strong> H. Collaboration Summary</strong></summary>

| Member Name | Main Contribution                            | Detailed Responsibilities                                                                                                                                                                                                                                                                                                                                                                  |
| ----------- | -------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Allan       | Docker setup, environment configuration      | 1. Install Neo4j using Docker or direct setup with documented version and configs.<br>2. Verify Neo4j instance runs.<br>3. Provide connection instructions for team (CLI/GUI).<br>4. Troubleshoot setup issues.<br>5. Document environment setup clearly in the lab manual.                                                                                                                |
| Brian       | CRUD operations implementation and scripting | 1. Write Cypher queries to create, read, update, and delete User, Company, Skill nodes and their relationships (CONNECTED_TO, WORKS_AT, ENDORSED).<br>2. Test each CRUD operation with the sample dataset.<br>3. Annotate queries with comments for clarity.<br>4. Work closely withJoel to ensure queries align with dataset structure.                                                   |
| Aicha       | Scenario design and screenshots collection   | 1. Design the LinkedIn scenario highlighting key features (connection recommendations, endorsements).<br>2. Draft clear, beginner-friendly explanations.<br>3. Collect screenshots of query results and database outputs.<br>4. Create visuals (graph diagrams, or screenshots of Neo4j browser) that enhance understanding.<br>5. Organize scenario walkthrough logically.                |
| Joel        | Dataset creation and query optimization      | 1. Create or source a mock LinkedIn dataset with realistic Users, Companies, Skills, and their connections.<br>2. Format data for easy Neo4j import (CSV/JSON).<br>3. Collaborate with Brian to align dataset structure with CRUD queries.<br>4. Optimize query performance by suggesting indexes or refactoring.<br>5. Test dataset with team and verify all lab operations run smoothly. |
                                                                                                                                                                   |

</details>

---

##  Supporting Files

Make sure your GitHub repo includes:

-`docker-compose.yml` (optional)
-`datasets/` folder (JSON, CSV, etc.)
- `images/` folder (for screenshots)
-`scripts/` folder (for helper scripts)
-`README.md` (this guide!)

---

## Final Submission Checklist

| Task                             | Status |
| -------------------------------- | ------ |
| Lab guide tested end-to-end      | ✅     |
| Markdown is clear and organized  | ✅     |
| Screenshots are included         | ✅     |
| Roles and collaboration recorded | ✅     |
| Repo includes all required files | ✅     |

---
