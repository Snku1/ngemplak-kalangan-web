<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ngemplak Kalangan</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">

    <!-- ===== FAVICON ===== -->
    <link rel="icon" type="image/svg+xml" href="{{ asset('favicon.svg') }}">
    <!-- atau pakai .ico -->
    <!-- <link rel="icon" type="image/x-icon" href="{{ asset('favicon.ico') }}"> -->
    <!-- atau pakai .svg (paling modern, ringan) -->
    <!-- <link rel="icon" type="image/svg+xml" href="{{ asset('favicon.svg') }}"> -->

    <!-- Apple Touch Icon (untuk iOS / mobile) -->
    <link rel="apple-touch-icon" href="{{ asset('favicon.svg') }}">

    <!-- Styles and Scripts -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="antialiased bg-gray-50 text-gray-900 font-sans">
    <div id="app"></div>
</body>
</html>
