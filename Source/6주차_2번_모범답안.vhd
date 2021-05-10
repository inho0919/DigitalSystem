-- HB_HA.VHD

ENTITY HB_HA IS
	PORT(
		A, B : IN  BIT;
		D, U : OUT BIT
	);
END HB_HA;

ARCHITECTURE HB OF HB_HA IS
BEGIN
	PROCESS(A, B)
	BEGIN
		IF (A = B) THEN
			D <= '0';
		ELSE
			D <= '1';
		END IF;
	END PROCESS;

	PROCESS(A, B)
	BEGIN
		IF (A < B) THEN
			U <= '1';
		ELSE
			U <= '0';
		END IF;
	END PROCESS;
END HB;
