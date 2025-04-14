import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Update Ticket Progress")

ticket_id = st.text_input("Enter Ticket Id:")
new_description = st.text_input("Enter the new status of the Ticket:")
if st.button("Update Ticket"):
    if ticket_id and new_description:

        data = {
            "ticket_status": new_description
        }
        response = requests.put(f"http://api:4000/m/tickets/", json=data)
        if response.status_code == 200:
            st.write(response)
        else:
            st.write("Could not connect to the API")
    else:
        st.write("Please enter all fields.")