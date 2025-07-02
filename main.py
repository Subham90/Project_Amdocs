import mysql.connector
from abc import ABC, abstractmethod

# ===========================================================
# DATABASE CONNECTION
# ===========================================================

class DatabaseConnection:
    """
    Handles connection and queries to the MySQL database.
    """
    def __init__(self):
        try:
            self.conn = mysql.connector.connect(
                host="localhost",
                user="root",
                password="Subham123@",
                database="hospital_db"
            )
            self.cursor = self.conn.cursor(buffered=True)
            print("Database connection established successfully.")
        except mysql.connector.Error as err:
            print(f"Database connection error: {err}")
            self.conn = None
            self.cursor = None

    def execute(self, query, params=None):
        if not self.conn or not self.cursor:
            print("Error: No active database connection.")
            return
        self.cursor.execute(query, params or ())
        self.conn.commit()

    def fetchall(self):
        if self.cursor:
            return self.cursor.fetchall()
        return []

    def fetchone(self):
        if self.cursor:
            return self.cursor.fetchone()
        return None

    def close(self):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()


# ===========================================================
# ABSTRACT BASE CLASSES
# ===========================================================

class BaseEntity(ABC):
    """
    Base class for all entities providing DB helpers.
    """
    def __init__(self, db):
        self.db = db

    def execute_query(self, query, params=None):
        self.db.execute(query, params)

    def fetch_all(self):
        return self.db.fetchall()

    def fetch_one(self):
        return self.db.fetchone()


class EntityManager(BaseEntity):
    """
    Abstract class enforcing add() and view() for entities.
    """
    @abstractmethod
    def add(self):
        pass

    @abstractmethod
    def view(self):
        pass


# ===========================================================
# DEPARTMENT MANAGEMENT
# ===========================================================

class Department(EntityManager):
    def add(self):
        try:
            dept_id = input("Enter Department ID: ")
            name = input("Enter Department Name: ")
            fee = int(input("Enter Department Fee: "))
            symptoms = input("Enter Department Symptoms: ")

            query = """
                INSERT INTO Departments (Dept_ID, Dept_name, Dept_fee, Dept_Symptoms)
                VALUES (%s, %s, %s, %s)
            """
            self.execute_query(query, (dept_id, name, fee, symptoms))
            print("Department added successfully!")
        except Exception as e:
            print(f"Error adding department: {e}")

    def view(self):
        self.execute_query("SELECT * FROM Departments")
        for row in self.fetch_all():
            print(row)

    def increase_fee_annually(self):
        """
        Calls a stored procedure to increase fees by 5%.
        """
        try:
            self.db.cursor.callproc('Increase_Dept_Fee_Annually')
            self.db.conn.commit()
            print("Department fees increased by 5%.")
        except Exception as e:
            print(f"Error increasing fees: {e}")


# ===========================================================
# DOCTOR MANAGEMENT
# ===========================================================

class Doctor(EntityManager):
    def add(self):
        name = input("Doctor Name: ")
        gender = input("Gender: ")
        contact = input("Contact: ")
        email = input("Email: ")
        dept_id = input("Department ID: ")
        experience = int(input("Experience (years): "))

        query = """
            INSERT INTO Doctor (Doct_name, Doct_gender, Doct_Contact, Doct_Email, Dept_ID, Doctor_Experience)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        self.execute_query(query, (name, gender, contact, email, dept_id, experience))
        print("Doctor added successfully!")

    def view(self):
        self.execute_query("SELECT * FROM Doctor")
        for row in self.fetch_all():
            print(row)


# ===========================================================
# PATIENT MANAGEMENT
# ===========================================================

class Patient(EntityManager):
    def add(self):
        try:
            name = input("Name: ")
            gender = input("Gender: ")
            age = int(input("Age: "))
            blood_grp = input("Blood Group: ")
            contact = input("Contact: ")

            query = """
                INSERT INTO Patient_details (Patient_Name, Patient_Contacts, Patient_Gender, Patient_Age, BloogGrp)
                VALUES (%s, %s, %s, %s, %s)
            """
            self.execute_query(query, (name, contact, gender, age, blood_grp))
            print("Patient added successfully!")
        except Exception as e:
            print(f"Error adding patient: {e}")

    def view(self):
        self.execute_query("SELECT * FROM Patient_details")
        for row in self.fetch_all():
            print(row)

    def add_arrival_info(self):
        patient_id = int(input("Patient ID: "))
        arrival_date = input("Arrival Date (YYYY-MM-DD): ")
        symptoms = input("Symptoms: ")

        query = """
            INSERT INTO Patient_arrival_Info (Patient_ID, Arrival_Date, Symptoms)
            VALUES (%s, %s, %s)
        """
        self.execute_query(query, (patient_id, arrival_date, symptoms))
        print("Arrival info added!")


# ===========================================================
# APPOINTMENT MANAGEMENT
# ===========================================================

class Appointment(BaseEntity):
    def schedule_appointment(self):
        print("\n--- Schedule Appointment ---")

        # Show available patients
        self.execute_query("SELECT Patient_ID, Patient_Name, Patient_Contacts FROM Patient_details")
        patients = self.fetch_all()
        for p in patients:
            print(f"ID: {p[0]}, Name: {p[1]}, Contact: {p[2]}")

        patient_id = int(input("Select Patient ID: "))
        symptoms = input("Enter patient symptoms (for department suggestion): ")

        self.execute_query("SELECT GetDepartmentBySymptom(%s)", (symptoms,))
        suggested_dept = self.fetch_one()

        if suggested_dept and suggested_dept[0]:
            print(f"\nSuggested Department: {suggested_dept[0]}")
            use_suggested = input("Use this department? (y/n): ").lower()

            if use_suggested == 'y':
                self.execute_query(
                    "SELECT Dept_ID FROM Departments WHERE Dept_name = %s",
                    (suggested_dept[0],)
                )
                dept = self.fetch_one()
                if not dept:
                    print("Department not found!")
                    return
                dept_id = dept[0]
            else:
                dept_id = self.ask_department_manually()
        else:
            print("No department found for those symptoms.")
            dept_id = self.ask_department_manually()

        self.execute_query("SELECT Doct_ID, Doct_name, Doctor_Experience FROM Doctor WHERE Dept_ID = %s", (dept_id,))
        doctors = self.fetch_all()

        if not doctors:
            print("No doctor available in this department!")
            return

        print("\nAvailable Doctors:")
        for doc in doctors:
            print(f"ID: {doc[0]}, Name: {doc[1]}, Experience: {doc[2]} years")

        doctor_id = int(input("Select Doctor ID: "))

        date_input = input("Enter Appointment Date (YYYY-MM-DD): ")
        time_input = input("Enter Appointment Time (HH:MM:SS): ")
        datetime_combined = f"{date_input} {time_input}"

        query = """
            INSERT INTO Appointment (Patient_ID, Doctor_ID, Date_time)
            VALUES (%s, %s, %s)
        """
        self.execute_query(query, (patient_id, doctor_id, datetime_combined))
        print("Appointment scheduled successfully!")

    def ask_department_manually(self):
        self.execute_query("SELECT Dept_ID, Dept_name FROM Departments")
        departments = self.fetch_all()
        print("\nAvailable Departments:")
        for dept in departments:
            print(f"ID: {dept[0]}, Name: {dept[1]}")
        return input("Select Department ID: ")

    def view_appointments(self):
        print("\n--- All Appointments ---")
        self.execute_query("SELECT * FROM Appointment")
        for row in self.fetch_all():
            print(row)


# ===========================================================
# PRESCRIPTION MANAGEMENT
# ===========================================================

class Prescription(BaseEntity):
    def add_prescription(self):
        print("\n--- Add Prescription ---")
        appt_id = int(input("Appointment ID: "))

        self.execute_query("SELECT * FROM Appointment WHERE Appointment_ID = %s", (appt_id,))
        result = self.fetch_one()

        if not result:
            print("Error: Appointment ID not found.")
            return

        diagnosis = input("Diagnosis: ")
        prescription = input("Prescription: ")

        query = """
            INSERT INTO Patient_Prescription_History (Appt_ID, Diagnosis, Prescription)
            VALUES (%s, %s, %s)
        """
        self.execute_query(query, (appt_id, diagnosis, prescription))
        print("Prescription added successfully!")


# ===========================================================
# BILLING
# ===========================================================

class Billing(BaseEntity):
    def generate_bill(self):
        print("\n--- Generate Bill ---")
        try:
            appoint_id = int(input("Enter Appointment ID: "))

            self.execute_query(
                "SELECT Doctor_ID, Patient_ID FROM Appointment WHERE Appointment_ID = %s",
                (appoint_id,)
            )
            result = self.fetch_one()

            if not result:
                print("Appointment ID not found!")
                return

            doctor_id, _ = result

            self.execute_query("SELECT Dept_ID FROM Doctor WHERE Doct_ID = %s", (doctor_id,))
            dept_result = self.fetch_one()

            if not dept_result:
                print("Doctor's department not found!")
                return

            dept_id = dept_result[0]

            self.execute_query(
                "SELECT Dept_name, Dept_fee FROM Departments WHERE Dept_ID = %s",
                (dept_id,)
            )
            fee_result = self.fetch_one()

            if not fee_result:
                print("Department not found!")
                return

            dept_name, dept_fee = fee_result

            print("\nBill Details")
            print(f"Appointment ID: {appoint_id}")
            print(f"Department: {dept_name}")
            print(f"Amount to be Paid: ₹{dept_fee}")

        except Exception as e:
            print(f"Error generating bill: {e}")


# ===========================================================
# HOSPITAL MANAGEMENT CONSOLE
# ===========================================================

class HospitalConsole:
    def __init__(self):
        self.db = DatabaseConnection()
        self.department = Department(self.db)
        self.doctor = Doctor(self.db)
        self.patient = Patient(self.db)
        self.appointment = Appointment(self.db)
        self.prescription = Prescription(self.db)
        self.billing = Billing(self.db)

    def run(self):
        while True:
            print("\n--- Hospital Management Console ---")
            print("1. Add Department")
            print("2. View Departments")
            print("3. Increase Department Fees (5%)")
            print("4. Add Doctor")
            print("5. View Doctors")
            print("6. Add Patient")
            print("7. View Patients")
            print("8. Add Arrival Info")
            print("9. Schedule Appointment")
            print("10. View Appointments")
            print("11. Add Prescription")
            print("12. Generate Bill")
            print("0. Exit")

            choice = input("Enter choice: ")

            try:
                if choice == '1':
                    self.department.add()
                elif choice == '2':
                    self.department.view()
                elif choice == '3':
                    self.department.increase_fee_annually()
                elif choice == '4':
                    self.doctor.add()
                elif choice == '5':
                    self.doctor.view()
                elif choice == '6':
                    self.patient.add()
                elif choice == '7':
                    self.patient.view()
                elif choice == '8':
                    self.patient.add_arrival_info()
                elif choice == '9':
                    self.appointment.schedule_appointment()
                elif choice == '10':
                    self.appointment.view_appointments()
                elif choice == '11':
                    self.prescription.add_prescription()
                elif choice == '12':
                    self.billing.generate_bill()
                elif choice == '0':
                    print("Exiting...")
                    self.db.close()
                    break
                else:
                    print("Invalid choice. Try again.")

            except Exception as e:
                print(f"Error: {e}")


# ===========================================================
# MAIN
# ===========================================================

if __name__ == "__main__":
    console = HospitalConsole()
    console.run()
