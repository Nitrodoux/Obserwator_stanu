# Projektowanie obserwatora stanu w środowisku Matlab

Celem ćwiczenia jest nabycie przez studentów wiedzy i umiejętności w zakresie: 
- badania obserwowalności obiektów sterowania,
- projektowania obserwatora stanu pełnego rzędu (Luenbergera),
- projektowania obserwatora stanu zredukowanego rzędu ,
- minimalizacja błędu estymacji wektora stanu,
- projektowania regulatora od estymowanego wektora stanu,
- badania właściwości układu regulacji z obserwatorem i regulatorem stanu.

Badany obiekt okazał się na początku niestabilny. Aby zaprojektować obserwator stanu należało sprawdzić sterowalność i obserwowalność badanego obiektu. Pozwoliło to zaprojektować regulator stanu, a następnie do stabilnego obiektu regulator stanu. Do ich wyznaczenia zastosowano funkcję Ackermana, która umożliwia przesunięcie biegunów i stabilizację układu za pomocą wyznaczonych wzmocnień. Bieguny posiadają część zespoloną, dlatego odpowiedź układu charakteryzuje się niewielkimi drganiami podczas przed uzyskaniem stanu ustalonego. Zastosowanie regulatora całkującego pozwoliło na skompensowanie sygnału zakłócenia. 
Dla obserwatora stanu pełnego rzędu błąd estymacji wynosi 0, co świadczy o bardzo dobrym estymowaniu zmiennych stanu.  Obserwator spełnia zatem swoje zadanie.
W przypadku zastosowania obserwatora zredukowanego rzędu wyniki estymacji wypadają znacznie gorzej, a błąd estymacji wynosi dla zmiennych stanu x1 i x2 odpowiednio 0.6 i 1.75. Zastosowanie regulatora całkującego w tym przypadku powodowało utratę stabilności układu, ponieważ zastosowano tutaj regulator stanu K. Aby uzyskać pożądaną amplitudę zastosowano człon kompensacji uchybu N. Wymiar obserwatora zredukowanego jest o rząd mniejszy niż wymiar obserwatora pełnego.
Obserwator stanu jest niezbędny wszędzie tam gdzie niemożliwe jest poprzez bezpośrednią obserwację ustalić jaki jest stan fizyczny układu. Zamiast tego na wyjściu systemu obserwuje się pośrednie skutki jakie wywołuje stan wewnętrzny układu, na co pozwala obserwator stanu.
