const monthNameElement = document.getElementById('month-name');
const calendarGrid = document.getElementById('calendar-grid');
let currentDate = new Date(); 

function renderCalendar() {
    calendarGrid.innerHTML = ''; 
    
    let startOfWeek = new Date(currentDate);
    const dayIndex = startOfWeek.getDay(); 
    const diff = startOfWeek.getDate() - dayIndex + (dayIndex === 0 ? -6 : 1); 
    startOfWeek.setDate(diff);

    const options = { month: 'long', year: 'numeric' };
    monthNameElement.innerText = startOfWeek.toLocaleDateString('es-ES', options);

    const weekDays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

    for (let i = 0; i < 7; i++) {
        let day = new Date(startOfWeek);
        day.setDate(startOfWeek.getDate() + i);

        const card = document.createElement('div');
        card.className = 'day-card';
        
        if(day.toDateString() === new Date().toDateString()) {
            card.style.border = "2px solid #764ba2";
            card.style.backgroundColor = "#f0eaff";
        }

        card.innerHTML = `
            <div class="day-name">${weekDays[i]}</div>
            <div class="day-number">${day.getDate()}</div>
            <div style="font-size: 0.7rem; color: #888;">Evento +</div>
        `;
        calendarGrid.appendChild(card);
    }
}

document.getElementById('prevWeek').addEventListener('click', () => {
    currentDate.setDate(currentDate.getDate() - 7);
    renderCalendar();
});

document.getElementById('nextWeek').addEventListener('click', () => {
    currentDate.setDate(currentDate.getDate() + 7);
    renderCalendar();
});

renderCalendar();