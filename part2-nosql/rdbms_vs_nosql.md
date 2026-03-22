Database Recommendation

For a healthcare patient management system, I'd recommend MySQL as the primary database, and here's why.

Medical data is where ACID compliance stops being a nice-to-have and becomes a safety requirement. ACID — Atomicity, Consistency, Isolation, Durability — means that when a nurse updates a patient's medication dosage and a doctor reads it simultaneously, they both see exactly the same consistent value. MongoDB operates on BASE principles (Basically Available, Soft state, Eventual consistency), which means two clients could temporarily see different versions of the same record. In a healthcare context, that's not a performance trade-off — it's a patient safety issue.

The CAP theorem also supports this choice. MySQL prioritizes Consistency and Partition Tolerance, which is exactly what a system holding prescriptions, allergies, and treatment histories needs. MongoDB prioritizes Availability — better for systems where "fast and good enough" matters more than "exactly correct every time."

Patient management data also has a well-defined, stable schema: patient demographics, appointments, diagnoses, prescriptions, billing. This maps naturally to relational tables. MongoDB's flexible schema would be mostly unused here and could allow data inconsistencies to creep in over time without strict application-level enforcement.

If a fraud detection module is added, the answer shifts.** Fraud detection works on large volumes of behavioral data — login patterns, device fingerprints, unusual claim sequences — that is unstructured, high-volume, and often graph-shaped. Here I'd recommend a hybrid: keep the core patient system in MySQL for ACID integrity, and add MongoDB (for flexible event logging) or a graph database like Neo4j (for detecting suspicious relationship patterns) as a separate fraud layer. The two systems serve fundamentally different purposes and don't need to be the same database.
