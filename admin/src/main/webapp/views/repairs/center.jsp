<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar</title>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- FullCalendar CSS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FullCalendar JS -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>

    <style>
        :root {
            --primary-color: #2C3E50;
            --accent-color: #3498DB;
            --bg-gradient: linear-gradient(135deg, #1a2b3c 0%, #2C3E50 100%);
            --event-color: #3498DB;
            --hover-color: #2980B9;
        }

        body {
            margin: 0;
            padding: 20px;
            font-family: 'Arial', sans-serif;
            background: var(--bg-gradient);
            min-height: 100vh;
            color: #ECF0F1;
        }

        .calendar-container {
            max-width: 1200px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 15px;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
        }

        .calendar-title {
            text-align: center;
            margin-bottom: 30px;
            color: #ECF0F1;
            font-size: 2.5em;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }

        #calendar {
            background: rgba(255, 255, 255, 0.05);
            padding: 20px;
            border-radius: 10px;
        }

        /* FullCalendar 커스텀 스타일 */
        .fc {
            background: transparent;
        }

        .fc-toolbar-title {
            color: #ECF0F1 !important;
            font-size: 1.5em !important;
            font-weight: bold !important;
        }

        .fc-button-primary {
            background-color: var(--accent-color) !important;
            border-color: var(--accent-color) !important;
            color: white !important;
            padding: 8px 16px !important;
            border-radius: 5px !important;
            transition: all 0.3s ease !important;
        }

        .fc-button-primary:hover {
            background-color: var(--hover-color) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }

        .fc-daygrid-day {
            background: rgba(255, 255, 255, 0.05) !important;
            border: 1px solid rgba(255, 255, 255, 0.1) !important;
        }

        .fc-daygrid-day-number {
            color: #ECF0F1 !important;
            font-weight: 500;
            padding: 8px !important;
        }

        .fc-day-today {
            background: rgba(52, 152, 219, 0.2) !important;
        }

        .fc-event {
            background-color: var(--event-color) !important;
            border: none !important;
            padding: 3px 5px !important;
            margin: 2px 0 !important;
            border-radius: 4px !important;
            cursor: pointer !important;
            transition: all 0.3s ease !important;
        }

        .fc-event:hover {
            transform: translateY(-1px);
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
        }

        .fc-day-header {
            color: #ECF0F1 !important;
            font-weight: bold !important;
        }

        .fc-col-header-cell {
            background: rgba(255, 255, 255, 0.1) !important;
            color: #ECF0F1 !important;
        }

        /* 반응형 스타일 */
        @media (max-width: 768px) {
            .calendar-container {
                margin: 10px;
                padding: 10px;
            }

            .calendar-title {
                font-size: 1.8em;
            }

            .fc-toolbar {
                flex-direction: column;
            }

            .fc-toolbar-chunk {
                margin: 5px 0;
            }
        }
    </style>
</head>
<body>
<div class="calendar-container">
    <h2 class="calendar-title">Schedule Management</h2>
    <div id="calendar"></div>
</div>
<script>
    $(document).ready(function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek,dayGridDay'
            },
            locale: 'ko',
            editable: true,
            dayMaxEvents: true,
            selectable: true,
            selectMirror: true,

            select: function(arg) {
                var title = prompt('새로운 일정을 입력하세요:');
                if (title) {
                    calendar.addEvent({
                        title: title,
                        start: arg.start,
                        end: arg.end,
                        allDay: arg.allDay,
                        backgroundColor: '#3498DB',
                        borderColor: '#3498DB'
                    });
                }
                calendar.unselect();
            },

            eventClick: function(arg) {
                if (confirm('이 일정을 삭제하시겠습니까?')) {
                    arg.event.remove();
                }
            },

            events: [
                {
                },
                {

                }
            ]
        });

        calendar.render();
    });
</script>
</body>
</html>