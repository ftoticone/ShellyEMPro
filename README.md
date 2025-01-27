#  Calculation of energy consumption by country electric billing scheme for Shelly EM Pro

The main script is <em>emdata_batch.sh</em>. As parameter it requires the path folder which contains the csv files exported by Shelly Pro EM over time. An example of exported csv is attached and contains the minute by minute energy consumption (i.e. <em>emdata_34987A450088_20250103.csv</em>). 

The <em>electric_billing_range.sh</em> requires installation of "calendar" command and calendar list of bank holidays. Attached there is the calendar list of italian bank holidays (i.e. <em>calendar.italian</em>).

All bash scripts and calendar list of bank holidays have to be located in the same path.

This is an example of script execution:
<code>
./emdata_batch.sh ./emdata_data_files/
Merging phase
DONE
<br>
Converting phase
Reading and converting data
Progress : [########################################] 100.00%
DONE
<br>
Storing data
Progress : [########################################] 100.00%
DONE
<br>
Shelly Pro EM data converted and saved in emdata_converted_20250114132524.csv
</code>

The result of execution is saved in a csv file named by "emdata_converted". Attached file <em>emdata_converted_20250114132524.csv is the result of <em>emdata_34987A450088_20250103.csv</em>.

For further information about italian eletric billing range please refer to the following <a href="https://www.arera.it/bolletta/glossario-dei-termini/dettaglio/fasce-orarie">link</a>
