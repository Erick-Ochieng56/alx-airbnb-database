
---

### ✅ `normalization.md`

```markdown
# Task 1: Normalize Your Database Design

## Objective
Ensure that the database design is in the third normal form (3NF).

---

## Step 1: First Normal Form (1NF)
- Each table has a primary key.
- All attributes have atomic (indivisible) values.

✅ **Achieved** by defining appropriate primary keys and using scalar types (e.g., VARCHAR, DATE).

---

## Step 2: Second Normal Form (2NF)
- Meets 1NF.
- All non-key attributes are fully functionally dependent on the entire primary key.

✅ **Achieved** by eliminating partial dependencies. Example: Booking depends entirely on both `property_id` and `user_id`.

---

## Step 3: Third Normal Form (3NF)
- Meets 2NF.
- All attributes are only dependent on the primary key (no transitive dependency).

✅ **Achieved**:
- Separated Review from Property and User.
- Messages link users using IDs rather than storing names/emails directly.

---

## Summary

The schema avoids redundancy, eliminates partial and transitive dependencies, and is normalized up to 3NF.
