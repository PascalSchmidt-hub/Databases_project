#Gym database CRUD App with tkinter
#Import needed modules
import tkinter as tk
from tkinter import ttk
import psycopg2

#Connect to database
con = psycopg2.connect(database="Gym", user="postgres", password="Frankfurt1", host="127.0.0.1", port="5432")
cur = con.cursor()

#Create gui settings
class gui_settings(tk.Tk):
	def __init__(self, *args, **kwargs):
		tk.Tk.__init__(self, *args, **kwargs)

		#Create container for Layout
		container = tk.Frame(self)
		container.pack(side = "top", fill = "both", expand = True)
		container.grid_rowconfigure(0, weight = 1)
		container.grid_columnconfigure(0, weight = 1)
		self.frames = {}

		#Iterate pages and at first show startpage
		for pages in (start_page, create_page, read_page, update_page, delete_page):
			frame = pages(container, self)
			self.frames[pages] = frame
			frame.grid(row = 0, column = 0, sticky ="nsew")
		self.show_frame(start_page)

	#Function show selected page
	def show_frame(self, cont):
		frame = self.frames[cont]
		frame.tkraise()

#Layout startpage
class start_page(tk.Frame):
	def __init__(self, parent, controller):
		tk.Frame.__init__(self, parent)
		#Page label
		label = ttk.Label(self, text ="Gym database App")
		label.grid(row = 0, column=2, padx = 10, pady = 10)

        #4 buttons in startpage:
		#Button create
		button_create = ttk.Button(self, text ="Create Member", command = lambda : controller.show_frame(create_page))
		button_create.grid(row = 1, column = 1, padx = 10, pady = 10)

        #Button read
		button_read = ttk.Button(self, text ="List Member", command = lambda : controller.show_frame(read_page))
		button_read.grid(row = 1, column = 2, padx = 10, pady = 10)

        #Button update
		button_update = ttk.Button(self, text ="Update Member", command = lambda : controller.show_frame(update_page))
		button_update.grid(row = 1, column = 3, padx = 10, pady = 10)

		#Button delete
		button_delete = ttk.Button(self, text ="Delete Member", command = lambda : controller.show_frame(delete_page))
		button_delete.grid(row = 1, column = 4, padx = 10, pady = 10)

#Layout create page
class create_page(tk.Frame):
	def __init__(self, parent, controller):

		#Function to create a member
		def command_insert():

			#Find all existing member_ids
			cur.execute("SELECT member_id from member ")
			all_member_ids = cur.fetchall()
			con.commit()
			member_list = []
			for x in range(len(all_member_ids)):
				member_list.append(str(all_member_ids[x][0]))

			#Find all existing base_ids
			cur.execute("SELECT base_id from member ")
			all_base_ids = cur.fetchall()
			con.commit()
			base_list = []
			for x in range(len(all_base_ids)):
				base_list.append(all_base_ids[x][0])

			#Insert data into member-table if member_id not already existing and base_id is valid
			if entry_member_id_insert.get() in member_list:
				ttk.Label(self, text=f"Member_id {entry_member_id_insert.get()} is already existing").grid(row = 3, column = 1, padx = 10, pady = 10)
			elif entry_base_id_insert.get() not in base_list:
				ttk.Label(self, text=f"Base_id {entry_base_id_insert.get()} is not valid. Entry e.g. FRA").grid(row = 7, column = 1, padx = 10, pady = 10)
			else:
				cur.execute(f"INSERT INTO member (member_id,fname,lname,birthdate,sex,e_mail,entry_date,end_date,bracelet_num,trainer_id,sub_name,base_id) VALUES ({entry_member_id_insert.get()}, '{entry_fname_insert.get()}', '{entry_lname_insert.get()}', null, '{entry_sex_insert.get()}', '{entry_email_insert.get()}', null, null, null, null, null, '{entry_base_id_insert.get()}')")
				con.commit()
				label_show_inserted_member = ttk.Label(self, text=f"Successfully created Member with Member-ID: {entry_member_id_insert.get()}")
				label_show_inserted_member.grid(row = 10, column = 1, padx = 10, pady = 10)

		tk.Frame.__init__(self, parent)
		
		#Page label
		label = ttk.Label(self, text ="Create Member")
		label.grid(row = 0, column = 1, padx = 10, pady = 10)

        #Button back to startpage
		button_back = ttk.Button(self, text ="Back", command = lambda : controller.show_frame(start_page))
		button_back.grid(row = 1, column = 1, padx = 10, pady = 10)

		#Needed entrys to create a new member
		entry_member_id_insert = ttk.Entry(self)
		entry_member_id_insert.insert(0, "Member-ID")
		entry_member_id_insert.grid(row = 2, column = 1, padx = 10, pady = 10)

		entry_fname_insert = ttk.Entry(self)
		entry_fname_insert.insert(0, "First Name")
		entry_fname_insert.grid(row = 2, column = 2, padx = 10, pady = 10)

		entry_lname_insert = ttk.Entry(self)
		entry_lname_insert.insert(0, "Last Name")
		entry_lname_insert.grid(row = 4, column = 1, padx = 10, pady = 10)

		entry_sex_insert = ttk.Entry(self)
		entry_sex_insert.insert(0, "Sex (M/F)")
		entry_sex_insert.grid(row = 4, column = 2, padx = 10, pady = 10)

		entry_base_id_insert = ttk.Entry(self)
		entry_base_id_insert.insert(0, "Base")
		entry_base_id_insert.grid(row = 6, column = 1, padx = 10, pady = 10)

		entry_email_insert = ttk.Entry(self)
		entry_email_insert.insert(0, "E-Mail")
		entry_email_insert.grid(row = 6, column = 2, padx = 10, pady = 10)

		#Button create with function to check if member_id already exists and base_id is possible
		button_create= ttk.Button(self, text="Create Member", command=command_insert)
		button_create.grid(row = 8, column = 1, padx = 30, pady = 10)

#Layout read page
class read_page(tk.Frame):
	def __init__(self, parent, controller):

		#Function to read/list a member
		def command_read():

			#Find all existing member_ids
			cur.execute("SELECT member_id from member ")
			all_member_ids = cur.fetchall()
			con.commit()
			member_list = []
			for x in range(len(all_member_ids)):
				member_list.append(str(all_member_ids[x][0]))

			#List member data if member_id exists
			if entry_read_member_id.get() in member_list:
				cur.execute(f"SELECT member_id, fname, lname, birthdate, sex, e_mail, base_id from member where member_id = {entry_read_member_id.get()}")
				member_data = cur.fetchall()
				ttk.Label(self, text=f"member_id: {member_data[0][0]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"first name: {member_data[0][1]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"last name: {member_data[0][2]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"birthdate: {member_data[0][3]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"sex: {member_data[0][4]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"e-mail: {member_data[0][5]}").grid(column = 1, padx = 10)
				ttk.Label(self, text=f"base: {member_data[0][6]}").grid(column = 1, padx = 10)
			else:
				ttk.Label(self, text=f"{entry_read_member_id.get()} is not in listed in gym-database!").grid(column = 1, padx = 10, pady = 10)

		tk.Frame.__init__(self, parent)

		#Page label
		label = ttk.Label(self, text ="List Member")
		label.grid(row = 0, column = 1, padx = 10, pady = 10)
		
        #Button back to startpage
		button_back = ttk.Button(self, text ="Back", command = lambda : controller.show_frame(start_page))
		button_back.grid(row = 1, column = 1, padx = 10, pady = 10)

		#Entry member_id to read/list member
		entry_read_member_id= ttk.Entry(self)
		entry_read_member_id.grid(row = 2, column = 1, padx = 10, pady = 10)

		#Button to get output
		button_read = ttk.Button(self, text="Show Data", command=command_read)
		button_read.grid(row = 3, column = 1, padx = 10, pady = 10)		

#Layout update page
class update_page(tk.Frame):
	def __init__(self, parent, controller):
		def command_update():

			#Find all existing member_ids
			cur.execute("SELECT member_id from member ")
			all_member_ids = cur.fetchall()
			con.commit()
			member_list = []
			for x in range(len(all_member_ids)):
				member_list.append(str(all_member_ids[x][0]))

			#Find all existing base_ids
			cur.execute("SELECT base_id from member ")
			all_base_ids = cur.fetchall()
			con.commit()
			base_list = []
			for x in range(len(all_base_ids)):
				base_list.append(all_base_ids[x][0])

			#Check if entries are valid, if yes update base_id
			if entry_update_member_id.get() not in member_list:
				ttk.Label(self, text=f"Member_id {entry_update_member_id.get()} is not in database").grid(row = 8, column = 1, padx = 10)
			elif entry_update_base_id.get() not in base_list:
				ttk.Label(self, text=f"Base_id {entry_update_base_id.get()} is not valid").grid(row = 9, column = 1, padx = 10)
			else:
				member_id_update = entry_update_member_id.get()
				base_id_update = entry_update_base_id.get()
				label_show_update = ttk.Label(self, text=f"New Base updated: {base_id_update} for {member_id_update}")
				label_show_update.grid(row = 7, column = 1, padx = 10)
				cur.execute(f"UPDATE member set base_id = '{base_id_update}' where member_id = {member_id_update}")
				con.commit()

		tk.Frame.__init__(self, parent)

		#Page label
		label = ttk.Label(self, text ="Update Member")
		label.grid(row = 0, column = 1, padx = 10, pady = 10)

		#Labels an entries to update a member
		label_update_member_id = ttk.Label(self, text="Please enter member_id:")
		label_update_member_id.grid(row = 2, column = 1, padx = 10)

		entry_update_member_id= ttk.Entry(self)
		entry_update_member_id.grid(row = 3, column = 1, padx = 10, pady = 10)

		label_update_base_id = ttk.Label(self, text="Please enter new base_id (e.g. HAM):")
		label_update_base_id.grid(row = 4, column = 1, padx = 10)

		entry_update_base_id= ttk.Entry(self)
		entry_update_base_id.grid(row = 5, column = 1, padx = 10, pady = 10)

		button_update= ttk.Button(self, text="Update", command=command_update)
		button_update.grid(row = 6, column = 1, padx = 10, pady = 10)
		
        #Button back to startpage
		button_back = ttk.Button(self, text ="Back", command = lambda : controller.show_frame(start_page))
		button_back.grid(row = 1, column = 1, padx = 10, pady = 10)

#Delete page
class delete_page(tk.Frame):
	def __init__(self, parent, controller):

		#Function to delete a member
		def command_delete():

			#Find all existing member-id's
			cur.execute("SELECT member_id from member ")
			all_member_ids = cur.fetchall()
			con.commit()
			member_list = []
			for x in range(len(all_member_ids)):
				member_list.append(str(all_member_ids[x][0]))
				member_id_delete = entry_member_id_delete.get()

			#Delete member if member_id is existing
			if member_id_delete in member_list:
				cur.execute(f"DELETE from MEMBER where member_id ={member_id_delete};")
				con.commit()
				label_show_deleted_member = ttk.Label(self, text=f"Successfully deleted Member with Member-ID: {member_id_delete}")
				label_show_deleted_member.grid(row = 5, column = 1, padx = 10, pady = 10)
			else:
				ttk.Label(self, text=f"{member_id_delete} is not in listed in gym-database!").grid(row = 6, column = 1, padx = 10, pady = 10)

		tk.Frame.__init__(self, parent)

		#Page label
		label = ttk.Label(self, text ="Delete Member")
		label.grid(row = 0, column = 1, padx = 10, pady = 10)
		
		#Label and entries to delete a member
		label_member_id_delete = ttk.Label(self, text="Please enter the ID of the Member you want to delete:")
		label_member_id_delete.grid(row = 2, column = 1, padx = 10)

		entry_member_id_delete = ttk.Entry(self)
		entry_member_id_delete.grid(row = 3, column = 1, padx = 10, pady = 10)

		button_delete= ttk.Button(self, text="Delete", command=command_delete)
		button_delete.grid(row = 4, column = 1, padx = 10, pady = 10)

        #Button back to startpage
		button_back = ttk.Button(self, text ="Back", command = lambda : controller.show_frame(start_page))
		button_back.grid(row = 1, column = 1, padx = 10, pady = 10)

#Start database GUI
app = gui_settings()
app.geometry("600x500")
app.mainloop()

