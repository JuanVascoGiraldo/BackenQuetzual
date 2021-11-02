var ctx = document.getElementById('docChart').getContext('2d');
var docChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['ETS', 'Anticonceptivos', 'Embarazo', 'Salud sexual femenina', 'Salud sexual masculina'],
        datasets: [{
            label: 'Puntos',
            data: [106, 101, 152, 141, 131],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: true,
        aspectRatio: 1,
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});