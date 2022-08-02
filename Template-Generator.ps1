$root = "C:\Program Files";
$templateLocation = "$root\CodeLouFrontEndTemplate" #change this to $boilerplateLocation
$displayBoilerplateInstructions = $false

$HTMLFileContents = @'
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="css/style.css" />
        <title>Code Lou Template</title>
    </head>
    <body>
        <header>
            <div class="banner">
                <h1>Hello World!</h1>
                <h2 id="nav-toggle" onclick="toggleNav()">O</h2>
            </div>
            <nav>
                <ul>
                    <li>
                        <a href="https://github.com/">Github</a>
                    </li>
                    <li>
                        <a href="https://www.codelouisville.org/">Code Lou</a>
                    </li>
                    <li>
                        <a href="https://developer.mozilla.org/en-US/">MDN</a>
                    </li>
                </ul>
            </nav>
        </header>
        <script src="js/app.js"></script>
    </body>
</html>
'@;

$CSSFileContents = @'
body {
    margin: 0;
}

.banner {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    background-color: brown;
    color: white;
}

nav {
    display: none;
    justify-content: space-evenly;
}

nav ul {
    list-style: none;
    padding: 0;
    display: grid;
    grid-template-columns: 1fr;
    text-align: center;
    background-color: rgb(167, 93, 93);
    margin: 0;
    width: 100%;
}

nav a {
    display: block;
    text-decoration: none; 
    color: white;
    margin: 0.5rem auto;
}

nav a:hover {
    font-weight: bold;
}

@media (min-width: 769px) {
    .banner {
        justify-content: space-evenly;
    }
    
    .banner > h2 {
        display: none;
    }

    nav {
        display: flex;
    }

    nav ul {
        grid-template-columns: 1fr 1fr 1fr;
    }
}

@media (min-width: 1025px) {
    
}
'@;

$JSFileContents = @'
console.log("Hello World");

function toggleNav() {
    let toggle = document.getElementById("nav-toggle");
    let navBar = document.querySelector("nav");

    if (toggle.textContent === "O") {
        toggle.textContent = "X";
        navBar.style.display = "flex";
    } else {
        toggle.textContent = "O";
        navBar.style.display = "none";
    }
}
'@;


if (!(Test-Path -Path $templateLocation)) {
    Write-Host "=[INFO]====================================================================================================="
    Write-Host "Boilerplate files not found.";
    Write-Host "Generating Boilerplate files in: $templateLocation";
    Write-Host ""
    New-Item -Path $root -Name "CodeLouFrontEndTemplate" -ItemType "directory" | Out-Null;
    $displayBoilerplateInstructions = $true;
};

if (!(Test-Path -Path "$templateLocation\index.html")) {
    Write-Host "Generating HTML Boilerplate";
    New-Item -Path $templateLocation -Name "index.html" -ItemType "file" | Out-Null;
    Set-Content -Path $templateLocation\index.html -Value $HTMLFileContents;
};

if (!(Test-Path -Path "$templateLocation\css")) {
    Write-Host "Generating CSS Boilerplate";
    New-Item -Path $templateLocation -Name "css" -ItemType "directory" | Out-Null;
    New-Item -Path "$templateLocation\css" -Name "style.css" -ItemType "file" | Out-Null;
    Set-Content -Path $templateLocation\css\style.css -Value $CSSFileContents;
};

if (!(Test-Path -Path "$templateLocation\js")) {
    Write-Host "Generating JS Boilerplate";
    New-Item -Path $templateLocation -Name "js" -ItemType "directory" | Out-Null;
    New-Item -Path "$templateLocation\js" -Name "app.js" -ItemType "file" | Out-Null;
    Set-Content -Path $templateLocation\js\app.js -Value $JSFileContents;
};

# Need to figure out signing...
Import-Module ./GenerateTemplate -Scope Global

if ($displayBoilerplateInstructions) {
    Write-Host ""
    Write-Host "=[INFO]====================================================================================================="
    Write-Host "To alter the files that created when a template generated, edit the files found in $templateLocation."
};