# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has function to add certain functionality to the left side bar of the app

import streamlit as st


#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="❓")


#### ------------------------ Role of exec ------------------------
def ExecHomeNav():
    st.sidebar.page_link(
        "pages/00_Exec_Home.py", label="Executive Board Member Home", icon="🕴️"
    )


def CreateEventNav():
    st.sidebar.page_link(
        "pages/01_Create_Event.py", label="Create Event", icon = "🗓️")
    
def GetSpecificEventNav():
    st.sidebar.page_link(
        "pages/02_Get_Specific_Event.py", label="Get Specific Event", icon = "📅")
    
def GetSpecificProjectNav():
    st.sidebar.page_link(
        "pages/03_Get_Specific_Project.py", label="Get Specific Project", icon = "🗃️")
    
def SeptProjectsNav():
    st.sidebar.page_link(
        "pages/04_AfterSeptember1_Projects.py", label="September and Beyond Projects", icon = "📁")
    
def UpdateEventNav():
    st.sidebar.page_link(
        "pages/05_Update_Event.py", label="Update Event", icon = "🔄")






## ------------------------ Role of general member ------------------------

def MemberHomeNav():
    st.sidebar.page_link(
        "pages/10_Member_Home.py", label="General Member Home", icon="🧍‍♂️")

def MemberEventsNav():
    st.sidebar.page_link(
        "pages/11_Member_Events.py", label="View Events", icon = "👯‍♀️")

def MemberGroupMeetingsNav():
    st.sidebar.page_link(
        "pages/12_Member_GroupMeetings.py", label="View Group Meetings", icon = "👩‍💻")

def MemberStatusUpdatesNav():
    st.sidebar.page_link(
        "pages/13_Member_StatusUpdates.py", label="View Status Updates", icon = "🔁")
    

def MemberPostStatusUpdateNav():
    st.sidebar.page_link(
        "pages/14_Member_PostStatusUpdate.py", label="Post Status Updates", icon = "⬆️")
    
def MemberTicketsNav():
    st.sidebar.page_link(
        "pages/15_Member_Tickets.py", label="Update Ticket Status", icon = "📄")
    
def MemberSeeProjectsNav():
    st.sidebar.page_link(
        "pages/16_Member_SeeProjects.py", label="See Projects", icon = "🗃️")
    
def MemberAddToProjectNav():
    st.sidebar.page_link(
        "pages/17_Member_AddToProject.py", label="Add Member to Project", icon = "🙋‍♂️")
    
def MemberSeeClientsNav():
    st.sidebar.page_link(
        "pages/18_Member_SeeClients.py", label="See Clients", icon = "💼")

## ------------------------ Role of advisor ------------------------


def AdvisorHomeNav():
    st.sidebar.page_link(
        "pages/20_Advisor_Home.py", label="Advisor Home", icon="💁‍♀️")

def AdvisorGetProposalNav():
    st.sidebar.page_link(
        "pages/21_Advisor_Get_Proposal.py", label="View Proposals", icon = "📘")
    
def AdvisorUpdateClientNav():
    st.sidebar.page_link(
        "pages/22_Advisor_Update_Client.py", label="Update Client Information", icon = "👤")
    
def AdvisorDeleteMemberNav():
    st.sidebar.page_link(
        "pages/23_Advisor_Delete_Member.py", label="Delete Member from Project", icon = "🙅‍♂️")

def AdvisorOfficeHoursNav():
    st.sidebar.page_link(
        "pages/24_Advisor_Office_Hours.py", label="Create Office Hours", icon = "📝")
    
def AdvisorGetProjectsNav():
    st.sidebar.page_link(
        "pages/25_Advisor_Get_Projects.py", label="View All Projects", icon = "📖")
    
def AdvisorCreateTicketNav():
    st.sidebar.page_link(
        "pages/26_Advisor_Create_Ticket.py", label ="Create a New Ticket", icon="🎟️")
    
    

## ------------------------ Role of client ------------------------


def ClientHomeNav():
    st.sidebar.page_link(
        "pages/30_Client_Home.py", label="Client Home", icon="👨‍💼")
    
def ClientGetInfoNav():
    st.sidebar.page_link(
        "pages/31_Client_Get_info.py", label="Get Client Information", icon = "💻")
    
def ClientChangeDescProjectNav():
    st.sidebar.page_link(
        "pages/32_change_desc_project.py", label="Change Project Description", icon = "✏️")
    
def ClientDeleteProjectNav():
    st.sidebar.page_link(
        "pages/33_delete_project.py", label="Delete Project", icon = "❌")
    
def ClientGetMemberInfoNav():
    st.sidebar.page_link(
        "pages/34_get_member_info.py", label="Get General Member Information", icon = "👱‍♂️")
    
def ClientGetExecInfoNav():
    st.sidebar.page_link(
        "pages/35_get_exec_info.py", label="Get Executive Member Information", icon = "ℹ️")







# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in.
    """

    # add a logo to the sidebar always
    st.sidebar.image("assets/Ideate_logo.png", width=150)

    # If there is no logged in user, redirect to the Home (Landing) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show World Bank Link and Map Demo Link if the user is a political strategy advisor role.
        if st.session_state["role"] == "exec_member":
            ExecHomeNav()
            CreateEventNav()
            GetSpecificEventNav()
            GetSpecificProjectNav()
            SeptProjectsNav()
            UpdateEventNav()

        # If the user role is usaid worker, show the Api Testing page
        if st.session_state["role"] == "general_member":
            MemberHomeNav()
            MemberEventsNav()
            MemberGroupMeetingsNav()
            MemberStatusUpdatesNav()
            MemberPostStatusUpdateNav()
            MemberTicketsNav()
            MemberSeeProjectsNav()
            MemberAddToProjectNav()
            MemberSeeClientsNav()

        # If the user is an administrator, give them access to the administrator pages
        if st.session_state["role"] == "advisor":
            AdvisorHomeNav()
            AdvisorGetProposalNav()
            AdvisorUpdateClientNav()
            AdvisorDeleteMemberNav()
            AdvisorOfficeHoursNav()
            AdvisorGetProjectsNav()
            AdvisorCreateTicketNav()

        if st.session_state["role"] == "client":
            ClientHomeNav()
            ClientGetInfoNav()
            ClientChangeDescProjectNav()
            ClientDeleteProjectNav()
            ClientGetMemberInfoNav()
            ClientGetExecInfoNav()

    # Always show the About page at the bottom of the list of links
    AboutPageNav()


    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
